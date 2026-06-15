local utils_url = require('utils.url')

local M = {}

local function get_version(filetype)
  if filetype == "ruby" then
    return vim.fn.system("ruby -e 'print RUBY_VERSION'")
  elseif filetype == "lua" then
    return '5.1' -- onlu using lua with neovim for now at least
  else
    return nil
  end
end

local function docs_url(filetype, version, query)
  if filetype == "ruby" then
    version = "master" -- get_version(filetype) the "q" query param doesn't work with versions below master for now
    return "https://docs.ruby-lang.org/en/" .. version .. "/?q=" .. query
  elseif filetype == "lua" then
    version = version or get_version(filetype)
    return "https://devdocs.io/#q=lua5.1 " .. query
  elseif version ~= nil then
    return "https://devdocs.io/#q=" .. filetype .. version .. " " .. query
  else
    return "https://devdocs.io/#q=" .. filetype .. " " .. query
  end
end

M.search = function(query)
  local filetype = vim.bo.filetype
  query = query or vim.fn.input("Search " .. filetype .. " docs: ")
  local url = docs_url(filetype, nil, query)

  utils_url.open(url)
end

M.search("form")

return M
