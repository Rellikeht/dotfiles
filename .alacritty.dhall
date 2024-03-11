{ bell = { animation = "EaseOutExpo", color = "#023210", duration = 0 }
, colors =
  { bright =
    { black = "#666666"
    , blue = "#7aa6da"
    , cyan = "#70d8c4"
    , green = "#02fa3a"
    , magenta = "#e377ef"
    , red = "#ea1a2f"
    , white = "#eaeaea"
    , yellow = "#e7c547"
    }
  , cursor = { cursor = "#40ffff", text = "#000000" }
  , normal =
    { black = "#0d0f11"
    , blue = "#2a82be"
    , cyan = "#8abeb7"
    , green = "#b5bd68"
    , magenta = "#b294bb"
    , red = "#cf1f1f"
    , white = "#95a8d6"
    , yellow = "#cfca4f"
    }
  , primary =
    { background = "#000108"
    , bright_foreground = "#02aacd"
    , dim_foreground = "#020a0f"
    , foreground = "#0f58d0"
    }
  , search.matches = { background = "#002412", foreground = "#0256ce" }
  , selection.background = "#0f6faf"
  }
, cursor.style = "Block"
, debug =
  { log_level = "Warn", persistent_logging = False, print_events = False }
, env.TERM = "alacritty"
, font =
    let family = "MesloLGS NF"

    in  { size = 12.0
        , bold = { family, style = "Bold" }
        , bold_italic = { family, style = "Bold Italic" }
        , italic = { family, style = "Italic" }
        , normal = { family, style = "Regular" }
        }
, keyboard.bindings
  =
  [ { action = "Paste", key = "V", mode = None Text, mods = "Control|Alt" }
  , { action = "Copy", key = "C", mode = None Text, mods = "Control|Alt" }
  , { action = "ScrollPageUp"
    , key = "P"
    , mode = None Text
    , mods = "Control|Alt"
    }
  , { action = "ScrollPageDown"
    , key = "N"
    , mode = None Text
    , mods = "Control|Alt"
    }
  , { action = "ScrollToTop"
    , key = "Comma"
    , mode = None Text
    , mods = "Shift|Control|Alt"
    }
  , { action = "ScrollToBottom"
    , key = "Period"
    , mode = None Text
    , mods = "Shift|Control|Alt"
    }
  , { action = "ScrollPageUp"
    , key = "PageUp"
    , mode = Some "~Alt"
    , mods = "Shift"
    }
  , { action = "ScrollPageDown"
    , key = "PageDown"
    , mode = Some "~Alt"
    , mods = "Shift"
    }
  , { action = "ScrollToTop", key = "Home", mode = Some "~Alt", mods = "Shift" }
  , { action = "ScrollToBottom"
    , key = "End"
    , mode = Some "~Alt"
    , mods = "Shift"
    }
  ]
, scrolling = { history = 10000, multiplier = 3 }
, window =
  { startup_mode = "Maximized"
  , title = "Alacritty"
  , dynamic_title = True
  , opacity = 0.95
  }
, terminal.osc52 = "CopyPaste"
, selection.save_to_clipboard = True
}
