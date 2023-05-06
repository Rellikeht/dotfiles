-- KEYMAPS

function mkeymap(mode, src, dest, options)
	vim.keymap.set(mode, src, dest, options)
end

function keymap(src, dest, options)
	mkeymap('', src, dest, options)
end

function nkeymap(src, dest, options)
	mkeymap('n', src, dest, options)
end

function vkeymap(src, dest, options)
	mkeymap('v', src, dest, options)
end
