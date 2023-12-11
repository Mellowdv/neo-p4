local cache = {}

cache.build_cache = function()
    local json_info = io.popen("p4 -Mj -z tag info"):read("a")
    local _, _, p4_client = string.find(json_info, "\"clientName\":\"(.-)\",")
    local command = string.format("p4 -Mj -z tag changes --me -l -s pending -c %s", p4_client)
    local p4_result = io.popen(command):read("a")
    local changelist_to_description_cache = {}
    for change_number, description in string.gmatch(p4_result, "\"change\":\"(.-)\",.-\"desc\":\"(.-)\",") do
        local split_description = {}
        for new_line in string.gmatch(description, "(.-)\\n") do
            table.insert(split_description, new_line)
        end
        changelist_to_description_cache[change_number] = split_description
    end
    return changelist_to_description_cache
end

return cache
