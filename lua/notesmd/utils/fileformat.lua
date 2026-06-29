local M = {}

---@param text string
---@return string
function M.slugify(text)
    return (text:lower():gsub("[^%w]", "_"):gsub("^_+", ""):gsub("_+$", ""))
end

return M
