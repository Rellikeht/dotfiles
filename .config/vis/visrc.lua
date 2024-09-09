-- load standard vis module, providing parts of the Lua API
require("vis")

local plugins = { --  {{{

  -- don't even need config {{{
  {"https://repo.or.cz/vis-goto-file.git"},
  {"https://gitlab.com/muhq/vis-lockfiles"},
  {"https://github.com/jpaulogg/vis-ins-completion"},
  {"https://github.com/milhnl/vis-backspace"},
  {"https://github.com/milhnl/vis-options-backport"},
  {"https://github.com/lutobler/vis-commentary"},
  {"https://repo.or.cz/vis-surround.git"},
  --  }}}

  {"https://repo.or.cz/vis-pairs.git"},
  {"https://repo.or.cz/vis-quickfix.git"},
  {"https://git.cepl.eu/cgit/vis/vis-fzf-open/"},

  --  {{{ ???
  -- only 2 char combinations
  -- {"https://github.com/erf/vis-sneak"},

  -- do I need this ?
  -- {"https://github.com/thimc/vis-colorizer"},

  -- and this ?
  -- {
  --   url = "https://github.com/peaceant/vis-fzf-mru",
  --   file = "fzf-mru",
  -- },

  -- and this ?
  -- {
  --   url = "https://github.com/jocap/vis-filetype-settings",
  --   file = "vis-filetype-settings",
  -- },

  -- }}}

} --  }}}

require("plugins/vis-plug").init(plugins, true)

-- because path can't work by default somehow {{{
local cache = os.getenv("XDG_CACHE_HOME")
if cache == nil then cache = os.getenv("HOME") .. "/.cache" end
package.path = cache .. "/vis-plug/plugins/?/?.lua;" .. cache ..
                 "/vis-plug/plugins/?/init.lua;" .. package.path
--  }}}

local p = require "vis-pairs" --  {{{
p.autopairs = false
p.map = {
  {["_"] = {"*", "*", name = "italics"}, ["*"] = {"**", "**"}},
}

--  }}}

-- TODO A bindings, greps
local qf = require("vis-quickfix") --  {{{

qf.grepprg = 'grep -HEIn --exclude-dir=.git'
qf.peek = true
qf.menu = false

-- New maps can't be added without modifying
-- code of plugin, because everything is encapsulated
-- no hook or something is exposed and lua api totally
-- lacks any option to check which window is opened
-- what title it has or anything to differentiate
-- Simply: one big useless shit

--  }}}

-- TODO B bindings
local fop = require("vis-fzf-open") --  {{{

--  }}}

vis.events.subscribe( --  {{{
  vis.events.INIT, function()
    -- Your global configuration options

    vis:command("map! normal <C-n> <vis-motion-totill-repeat>")
    vis:command("map! normal <C-p> <vis-motion-totill-reverse>")
    vis:command("map! normal ; <C-w>")

    vis:command("set autoindent on")
    vis:command("set ignorecase on")

    -- this does nothing
    vis:command("set escdelay 0")

    -- and this probably too
    vis:command("set shell bash")
  end
) --  }}}

vis.events.subscribe( --  {{{
  vis.events.WIN_OPEN, function(win)
    -- Your per window configuration options e.g.

    -- why can't that work in previous section
    vis:command("set number on")
    vis:command("set relativenumbers on")
    vis:command("set theme darkest-space")
    vis:command("set expandtab on")
    vis:command("set cursorline on")
    vis:command("set showtabs on")
    vis:command("set tabwidth 2")
  end
) --  }}}
