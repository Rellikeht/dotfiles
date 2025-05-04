---@diagnostic disable: lowercase-global
function mkeymap(mode, src, dest, options)
  vim.keymap.set(mode, src, dest, options)
end

function keymap(src, dest, options)
  mkeymap("", src, dest, options)
end

function nkeymap(src, dest, options)
  mkeymap("n", src, dest, options)
end

function vkeymap(src, dest, options)
  mkeymap("v", src, dest, options)
end

function commandRep(fn)
  return function() for _ = 1, vim.v.count1 do fn() end end
end

function fileReadable(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end
