-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/vis-sneak')
--require('plugins/vis-fzf')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	vis:command('set rnu on')
	vis:command('set change-256colors on')
	vis:command('set theme gruvbox')
	vis:command('set et off')
	vis:command('set show-tabs on')
	vis:command('set tw 3')
end)
