local shared = require("notesmd.shared")

local M = {}

---@param name string
function M.create(name)
    shared.create(name)
end

return M
