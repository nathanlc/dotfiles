local M = {}

function M.concat(tables)
  local result = {}
  for _, t in ipairs(tables) do
    for _, v in ipairs(t) do
      table.insert(result, v)
    end
  end
  return result
end

function M.reduce(callback, carry, t)
  for _, v in ipairs(t) do
    carry = callback(carry, v)
  end
  return carry
end

function M.filter(callback, t)
  return M.reduce(function(new_t, v)
    if callback(v) then
      table.insert(new_t, v)
    end
    return new_t
  end, {}, t)
end

function M.map(callback, t)
  return M.reduce(
    function(carry, v)
      table.insert(carry, callback(v))
      return carry
    end, {}, t)
end

function M.find(value, t)
  local index = nil
  for i, v in ipairs(t) do
    if value == v then
      index = i
      break
    end
  end
  return index
end

function M.unique(t)
  local unique = {}
  for _, v in ipairs(t) do
    if not M.find(v, unique) then
      table.insert(unique, v)
    end
  end
  return unique
end

function M.reverse(t)
  local reversed = {}
  for i=1, #t do
    table.insert(reversed, t[#t + 1 - i])
  end
  return reversed
end

function M.head(n, t)
  return { unpack(t, 1, n + 1) }
end

return M
