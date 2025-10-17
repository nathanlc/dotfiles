local Job = require('plenary.job')

local M = {}

local function prs_to_review_job(callback)
  return Job:new({
    'gh',
    'search',
    'prs',
    '--state=open',
    '--review-requested=@me',
    '--json',
    'title,number,url,repository',
    on_exit = function(job)
      local result = job:result()[1]
      callback(vim.json.decode(result))
    end
  })
end

function M.prs_to_review(callback)
  local job = prs_to_review_job(callback)

  return job:start()
end

function M.prs_to_review_sync()
  local prs = {}
  local job = prs_to_review_job(function(prs_decoded)
    prs = prs_decoded
  end)
  job:sync()

  return prs
end

local function prs_ongoing_job(callback)
  return Job:new({
    'gh',
    'search',
    'prs',
    '--state=open',
    '--author=@me',
    '--json',
    'title,number,url,repository',
    on_exit = function(job)
      local result = job:result()[1]
      callback(vim.json.decode(result))
    end
  })
end

function M.prs_ongoing(callback)
  local job = prs_ongoing_job(callback)

  return job:start()
end

function M.prs_ongoing_sync()
  local prs = {}
  local job = prs_ongoing_job(function(prs_decoded)
    prs = prs_decoded
  end)
  job:sync()

  return prs
end

function M.pr_checks()
  local job = Job:new({
    'gh',
    'pr',
    'checks',
    '--watch',
    '--fail-fast',
  })
  job:start()
  job:after_success(function()
    vim.schedule(function()
      vim.api.nvim_command([[silent !hs -c 'hs.alert.show("PR OK")']])
    end)
  end)
  job:after_failure(function()
    vim.schedule(function()
      vim.api.nvim_command([[silent !hs -c 'hs.alert.show("PR FAILED (or does not exist)")']])
    end)
  end)
end

return M
