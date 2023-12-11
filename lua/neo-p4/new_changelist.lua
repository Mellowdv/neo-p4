local new_changelist = {}

new_changelist.prev_bufnr = 0
local create_changelist = function()
    local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
    content = table.concat(content, "\n")
    local p4_cmd = io.popen("p4 change -i", "w")
    if p4_cmd ~= nil then
        p4_cmd:write(content)
        p4_cmd:close()
    end
    vim.api.nvim_buf_delete(0, {force = true})
    vim.api.nvim_win_set_buf(0, new_changelist.prev_bufnr)
end

new_changelist.create_cl = function()
    new_changelist.prev_bufnr = vim.api.nvim_get_current_buf()
    local new_bufnr = vim.api.nvim_create_buf(true, false)
    local p4_result = io.popen("p4 change -o"):read("a")
    local split_spec = {}
    for new_line in string.gmatch(p4_result, "(.-)\n") do
        table.insert(split_spec, new_line)
    end
    vim.api.nvim_buf_set_lines(new_bufnr, 0, -1, false, split_spec)
    vim.api.nvim_win_set_buf(0, new_bufnr)
    vim.api.nvim_buf_create_user_command(new_bufnr, "Wcl", create_changelist, {})
end

return new_changelist
