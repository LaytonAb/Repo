--[[function get_window(window, wind_id)
  local windows = vim.api.nvim_list_wins()

  local window_exists = false
  for _, win in ipairs(windows) do
    
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    
    if buf_name:match('term://') then
      local win_id = vim.api.nvim_get_current_win()
      return true, win_id 
      
      break
    end
  
  end

end


function toggle_terminal()
  local buffers = vim.api.nvim_list_bufs()

  for _, bufs in ipairs(buffers) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    
    if buf_name:match('term://') then
      local buf = vim.fn.bufnr(buf_name)
      window, win_id = get_window()

      if not window then
        vim.cmd('sp')
        vim.api.nvim_set_current_buf(buf)

      else
      end
    end
  
  end

end]]
