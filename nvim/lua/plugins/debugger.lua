local dap, dapui = require("dap"), require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Attach Springboot",
    hostName = "localhost",
    port = 8001,
  },
  {
    type = "java",
    request = "attach",
    name = "Attach Springboot (tests)",
    hostName = "localhost",
    port = 5005,
  },
}

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/Users/nathan/sandbox/apps/php_related/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    -- pathMappings = {
    --   ["/var/www/html"] = "${workspaceFolder}"
    -- }
  }
}
