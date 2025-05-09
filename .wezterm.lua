local wezterm = require 'wezterm'
--Test

local config = {}
  config.color_scheme = 'Obsidian'
  config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
  
  local mux = wezterm.mux
  wezterm.on("gui-startup", function(cmd)
      local tab, pane, window = mux.spawn_window(cmd or {})
      window:gui_window():maximize()
  end)

return config
