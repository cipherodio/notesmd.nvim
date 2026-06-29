local date = require("notesmd.utils.date")

local M = {}

---@param field_name string
local function stamp(field_name)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local found = false

    for i, line in ipairs(lines) do
        if line:match("^" .. field_name .. ":") then
            lines[i] = ('%s: "%s"'):format(field_name, date.timestamp())
            found = true
            break
        end
    end

    if found then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    else
        vim.notify(
            ("No '%s' field found in current buffer."):format(field_name),
            vim.log.levels.WARN
        )
    end
end

function M.complete()
    stamp("completed")
end

function M.upload()
    stamp("uploaded")
end

return M
