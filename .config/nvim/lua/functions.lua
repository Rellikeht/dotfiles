---@diagnostic disable: lowercase-global
-- keymaps {{{
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

function nvkeymap(src, dest, options)
  mkeymap("n", src, dest, options)
  mkeymap("v", src, dest .. "gv", options)
end

-- With more typical vim mappings
-- -- Insert 'n' lines below current line staying in normal mode (e.g. use 5<leader>o)
-- vim.keymap.set("n", "<leader>o", function()
--     return "m`" .. vim.v.count .. "o<Esc>``"
-- end, { expr = true })

-- -- Insert 'n' lines above current line staying in normal mode (e.g. use 5<leader>O)
-- vim.keymap.set("n", "<leader>O", function()
--     return "m`" .. vim.v.count .. "O<Esc>``"
-- end, { expr = true })

--  }}}

-- helpers {{{

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

--  }}}
