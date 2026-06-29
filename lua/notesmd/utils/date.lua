local M = {}

---@return string
function M.today()
    return (os.date("%b-%d-%Y-%a") --[[@as string]]):lower()
end

---@param format? string
---@return string
function M.timestamp(format)
    return os.date(format or "%B %d, %Y %a %I:%M %p") --[[@as string]]
end

return M
