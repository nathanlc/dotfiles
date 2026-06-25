/**
 * Cost Tracker Extension
 *
 * Tracks cumulative LLM costs across all sessions, persisted to a monthly ledger file:
 *   ~/.pi/agent/costs/YYYY-MM.json
 *
 * Each ledger file is independent, so costs survive session deletions and accumulate
 * correctly even across resumed sessions. Per-model costs are tracked alongside the total.
 *
 * Displays the running monthly total in the pi footer via setStatus().
 *
 * Commands:
 *   /cost          — open a full summary table (all months × all models) as an overlay
 *   /cost 2026-05  — show detail for a specific month inline
 */

import { readFileSync, writeFileSync, mkdirSync, existsSync, readdirSync } from "node:fs";
import { join } from "node:path";
import { homedir } from "node:os";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { matchesKey, Key, truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

const COSTS_DIR = join(homedir(), ".pi", "agent", "costs");
const STATUS_KEY = "cost-tracker";

interface MonthLedger {
  month: string; // "YYYY-MM"
  total: number;
  models: Record<string, number>; // model ID -> cumulative cost
  counted: string[]; // entry IDs already added to total
}

// ── Ledger helpers ────────────────────────────────────────────────────────────

function monthKey(date: Date = new Date()): string {
  return `${date.getUTCFullYear()}-${String(date.getUTCMonth() + 1).padStart(2, "0")}`;
}

function ledgerPath(month: string): string {
  return join(COSTS_DIR, `${month}.json`);
}

function loadLedger(month: string): { ledger: MonthLedger; countedSet: Set<string> } {
  const path = ledgerPath(month);
  let ledger: MonthLedger;
  if (existsSync(path)) {
    try {
      ledger = JSON.parse(readFileSync(path, "utf8"));
    } catch {
      ledger = { month, total: 0, models: {}, counted: [] };
    }
  } else {
    ledger = { month, total: 0, models: {}, counted: [] };
  }
  // Migrate ledgers written before model tracking was added
  ledger.models ??= {};
  return { ledger, countedSet: new Set(ledger.counted) };
}

function loadAllLedgers(): MonthLedger[] {
  if (!existsSync(COSTS_DIR)) return [];
  return readdirSync(COSTS_DIR)
    .filter((f) => f.endsWith(".json"))
    .map((f) => f.replace(".json", ""))
    .sort()
    .reverse() // newest first
    .map((month) => loadLedger(month).ledger);
}

function saveLedger(ledger: MonthLedger): void {
  mkdirSync(COSTS_DIR, { recursive: true });
  writeFileSync(ledgerPath(ledger.month), JSON.stringify(ledger, null, 2));
}

function formatCost(n: number): string {
  return `$${n.toFixed(3)}`;
}

// ── Summary overlay component ─────────────────────────────────────────────────

type Theme = Parameters<Parameters<ExtensionAPI["on"]>[1]>[1]["ui"]["theme"];

class CostSummaryComponent {
  private onClose: () => void;
  private theme: Theme;
  private cachedLines?: string[];
  private cachedWidth?: number;

  constructor(theme: Theme, onClose: () => void) {
    this.theme = theme;
    this.onClose = onClose;
  }

  handleInput(data: string): void {
    if (matchesKey(data, Key.escape) || matchesKey(data, Key.ctrl("c"))) {
      this.onClose();
    }
  }

  invalidate(): void {
    this.cachedWidth = undefined;
    this.cachedLines = undefined;
  }

  render(width: number): string[] {
    if (this.cachedLines && this.cachedWidth === width) return this.cachedLines;
    this.cachedLines = this.buildLines(width);
    this.cachedWidth = width;
    return this.cachedLines;
  }

  private buildLines(width: number): string[] {
    const { theme } = this;
    const dim = (s: string) => theme.fg("dim", s);
    const accent = (s: string) => theme.fg("accent", s);
    const muted = (s: string) => theme.fg("muted", s);

    const allLedgers = loadAllLedgers();

    if (allLedgers.length === 0) {
      return [
        " " + accent("LLM Cost Summary"),
        "",
        " " + dim("No cost data recorded yet."),
        "",
        " " + dim("esc to close"),
      ];
    }

    // Aggregate model totals across all months
    const modelTotals: Record<string, number> = {};
    for (const l of allLedgers) {
      for (const [model, cost] of Object.entries(l.models)) {
        modelTotals[model] = (modelTotals[model] ?? 0) + cost;
      }
    }
    const grandTotal = allLedgers.reduce((s, l) => s + l.total, 0);

    // Models sorted by total spend, descending
    const models = Object.keys(modelTotals).sort((a, b) => modelTotals[b]! - modelTotals[a]!);

    // ── Column layout ──────────────────────────────────────────────────────
    const INDENT = 1;
    const GAP = 2;
    const MONTH_W = 9;  // "2026-06" = 7, "All-time" = 8
    const COST_W = 8;   // "$12.345" = 7
    // Distribute remaining width equally across model columns
    const availForModels = width - INDENT - MONTH_W - GAP - COST_W - GAP;
    const modelColW = models.length > 0
      ? Math.max(8, Math.floor(availForModels / models.length) - GAP)
      : 0;
    // How many model columns actually fit?
    const maxModelCols = availForModels > 0 && modelColW > 0
      ? Math.floor((availForModels + GAP) / (modelColW + GAP))
      : 0;
    const visibleModels = models.slice(0, maxModelCols);
    const hiddenCount = models.length - visibleModels.length;

    // ── Render helpers ─────────────────────────────────────────────────────
    // Pad/truncate a plain string to exact width (no ANSI)
    const col = (s: string, w: number): string =>
      s.length > w ? s.slice(0, w - 1) + "…" : s.padEnd(w);

    // Build one table row from pre-formatted cell strings
    const row = (cells: string[]): string =>
      " ".repeat(INDENT) + cells.join(" ".repeat(GAP));

    // ── Header ─────────────────────────────────────────────────────────────
    const headerCells = [
      col("Month", MONTH_W),
      col("Total", COST_W),
      ...visibleModels.map((m) => col(m, modelColW)),
    ];
    const sepCells = [
      "─".repeat(MONTH_W),
      "─".repeat(COST_W),
      ...visibleModels.map(() => "─".repeat(modelColW)),
    ];

    // ── Data rows ──────────────────────────────────────────────────────────
    const dataRows = allLedgers.map((l) => {
      const cells = [
        col(l.month, MONTH_W),
        col(formatCost(l.total), COST_W),
        ...visibleModels.map((m) => col(l.models[m] != null ? formatCost(l.models[m]!) : "—", modelColW)),
      ];
      return row(cells);
    });

    // ── Totals row ─────────────────────────────────────────────────────────
    const totalCells = [
      col("All-time", MONTH_W),
      col(formatCost(grandTotal), COST_W),
      ...visibleModels.map((m) => col(formatCost(modelTotals[m]!), modelColW)),
    ];

    const lines: string[] = [
      truncateToWidth(" " + accent("LLM Cost Summary"), width),
      "",
      truncateToWidth(dim(row(headerCells)), width),
      truncateToWidth(dim(row(sepCells)), width),
      ...dataRows.map((r) => truncateToWidth(r, width)),
      truncateToWidth(dim(row(sepCells)), width),
      truncateToWidth(accent(row(totalCells)), width),
    ];

    if (hiddenCount > 0) {
      lines.push("", truncateToWidth(" " + muted(`(+${hiddenCount} more model(s) not shown — terminal too narrow)`), width));
    }

    lines.push("", truncateToWidth(" " + dim("esc to close"), width));

    return lines;
  }
}

// ── Extension entry point ─────────────────────────────────────────────────────

export default function (pi: ExtensionAPI) {
  let currentMonth = monthKey();
  let ledger: MonthLedger;
  let countedSet: Set<string>;

  function load() {
    currentMonth = monthKey();
    ({ ledger, countedSet } = loadLedger(currentMonth));
  }

  function updateStatus(ctx: Parameters<Parameters<typeof pi.on<"session_start">>[1]>[1]) {
    const month = new Date().toLocaleString("default", { month: "short" });
    ctx.ui.setStatus(STATUS_KEY, ctx.ui.theme.fg("dim", `${month} ${formatCost(ledger.total)}`));
  }

  function addEntry(entryId: string, cost: number, model: string): boolean {
    if (countedSet.has(entryId)) return false;
    countedSet.add(entryId);
    ledger.total += cost;
    ledger.models[model] = (ledger.models[model] ?? 0) + cost;
    ledger.counted.push(entryId);
    saveLedger(ledger);
    return true;
  }

  // On session start: load ledger and catch up on any uncounted turns
  pi.on("session_start", async (_event, ctx) => {
    load();

    const branch = ctx.sessionManager.getBranch();
    let changed = false;
    for (const entry of branch) {
      if (entry.type !== "message") continue;
      const msg = entry.message;
      if (msg.role !== "assistant") continue;
      const entryMonth = monthKey(new Date(msg.timestamp));
      if (entryMonth !== currentMonth) continue;
      if (addEntry(entry.id, msg.usage.cost.total, msg.model)) changed = true;
    }
    if (changed) saveLedger(ledger);

    updateStatus(ctx);
  });

  // On each turn end: record the new assistant message
  pi.on("turn_end", async (event, ctx) => {
    const nowMonth = monthKey();
    if (nowMonth !== currentMonth) load();

    const msg = event.message;
    if (msg.role !== "assistant") return;

    const branch = ctx.sessionManager.getBranch();
    const entry = branch.find(
      (e) => e.type === "message" && e.message.role === "assistant" && e.message.timestamp === msg.timestamp,
    );
    if (!entry) return;

    addEntry(entry.id, msg.usage.cost.total, msg.model);
    updateStatus(ctx);
  });

  // /cost           → full summary overlay (all months × all models)
  // /cost YYYY-MM   → single-month detail inline
  pi.registerCommand("cost", {
    description: "Show LLM cost summary (/cost) or detail for a specific month (/cost 2026-05)",
    handler: async (args, ctx) => {
      const month = args.trim();

      if (!month) {
        // Full summary table as overlay
        await ctx.ui.custom(
          (_tui, theme, _kb, done) => new CostSummaryComponent(theme, done),
          { overlay: true, overlayOptions: { anchor: "center", maxHeight: "80%", margin: 2 } },
        );
        return;
      }

      // Single-month detail
      const { ledger: l } = loadLedger(month);
      const label = month === currentMonth ? `${month} (current)` : month;

      if (l.total === 0 && l.counted.length === 0) {
        ctx.ui.notify(`No cost data for ${label}`, "info");
        return;
      }

      const modelLines = Object.entries(l.models)
        .sort(([, a], [, b]) => b - a)
        .map(([model, cost]) => `  ${model}: ${formatCost(cost)}`)
        .join("\n");
      const breakdown = modelLines ? `\n${modelLines}` : "";
      ctx.ui.notify(
        `${label}: ${formatCost(l.total)} across ${l.counted.length} LLM turn(s)${breakdown}`,
        "info",
      );
    },
  });
}
