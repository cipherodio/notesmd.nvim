local date = require("notesmd.utils.date")

local M = {}

---@param fields NotesMDFrontmatterFields
---@param sort_order string[]
---@return string
function M.render(fields, sort_order)
    local lines = {
        "---",
    }

    for _, key in ipairs(sort_order) do
        local value = fields[key]

        if value ~= nil then
            if key == "created" then
                if value == true then
                    value = date.timestamp()
                elseif value == false then
                    goto continue
                elseif type(value) == "string" then
                    value = date.timestamp(value)
                end

                table.insert(lines, ('created: "%s"'):format(value))
                goto continue
            end

            if value == "" then
                table.insert(lines, ('%s: ""'):format(key))
            else
                table.insert(lines, ("%s: %s"):format(key, tostring(value)))
            end
        end

        ::continue::
    end

    table.insert(lines, "---")

    return table.concat(lines, "\n")
end

return M
