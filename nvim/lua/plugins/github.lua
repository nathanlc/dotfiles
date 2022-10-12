local Job = require('plenary.job')

local M = {}

function M.prs_to_review(run_async, callback)
  local job = Job:new({
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

  if run_async == true then
    job:start()
  else
    job:sync()
  end
end

function M.prs_ongoing(run_async, callback)
  local job = Job:new({
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

  if run_async == true then
    job:start()
  else
    job:sync()
  end
end

return M
