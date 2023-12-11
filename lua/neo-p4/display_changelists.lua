local display_changelists = {}

local function get_cl_numbers(cache)
    local changelist_numbers = {}
    print(vim.inspect(cache))
    for num, _ in pairs(cache) do
        table.insert(changelist_numbers, num)
    end
    return changelist_numbers
end


local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

Selected_changelist = nil
display_changelists.changelists = function(cache, opts)
    opts = opts or {}
    local changelist_numbers = get_cl_numbers(cache)
    pickers.new(opts, {
        prompt_title = "Changelists",
        finder = finders.new_table {
            results = changelist_numbers
        },
        sorter = conf.generic_sorter(opts),
        previewer = previewers.new_buffer_previewer {
            title = "Changelist description",
            define_preview = function(self, entry, status)
                local selection = action_state.get_selected_entry()
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, cache[selection[1]])
            end,
        },
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                Selected_changelist = selection[1]
            end)
            return true
        end,
    }):find()
end

return display_changelists
