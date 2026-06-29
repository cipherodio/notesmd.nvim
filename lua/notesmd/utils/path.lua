local M = {}

---@param root string
---@param dir string
---@return string
function M.join(root, dir)
    return root .. "/" .. dir
end

return M
