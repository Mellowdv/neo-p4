local M = {}

-- perform cheap checks (are necessary sys env variables set, is telescope available)
-- if env vars are not set or telescope not available, inform user
M.setup = function()
end

-- main functionality of the plugin
M._cache = {}
local cache = require("neo-p4.cache")
function M.update_cache()
    M._cache = cache.build_cache()
end

local display = require("neo-p4.display_changelists")
function M.display_changelists()
    display.changelists(M._cache, {})
end

local new_cl = require("neo-p4.new_changelist")
function M.create_changelist()
    new_cl.create_cl()
end

local edit_file = require("neo-p4.edit_file")
function M.edit_file()
    edit_file.edit()
end

M.delete_changelist = function()
end

M.change_spec = function()
end

return M
