-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/vis-sneak')
--require('plugins/vis-fzf')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.

   -- why can't that work in previous section
	vis:command('set number on')
	vis:command('set relativenumbers on')
	vis:command('set change-256colors on')
	vis:command('set theme dark-16')
	vis:command('set expandtab on')
	vis:command('set show-tabs on')
	vis:command('set tw 3')

end)
