local edit_file = {}

local action_state = require "telescope.actions.state"
edit_file.edit = function()
    local file_name = vim.api.nvim_buf_get_name(0)
    local selection = action_state.get_selected_entry()
    local selected_changelist = selection[1]
    io.popen(string.format("p4 edit -c %s %s", selected_changelist, file_name))
end

return edit_file
