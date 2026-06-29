local config = require("notesmd.config")
local date = require("notesmd.utils.date")
local frontmatter = require("notesmd.frontmatter")
local path = require("notesmd.utils.path")

local M = {}

---@param label string
---@return string
local function prompt(label)
    return vim.fn.input(label .. ": ")
end

---@param name string
function M.open(name)
    local note_type = config.get_type(name)
    if not note_type then
        return
    end

    local root = config.notes_dir()
    if not root then
        return
    end

    local directory = path.join(root, note_type.dir)
    local filename = date.today() .. ".md"
    local filepath = path.join(directory, filename)

    vim.fn.mkdir(directory, "p")

    if vim.fn.filereadable(filepath) == 0 then
        local fm = note_type.frontmatter or {}
        local fields = vim.deepcopy(fm.fields or {})

        if fields.title == "input" then
            fields.title = prompt("Title")
        end

        if fields.author == "input" then
            fields.author = prompt("Author")
        end

        local yaml = frontmatter.render(fields, fm.sort_order or {})

        local file = io.open(filepath, "w")
        if file then
            file:write(yaml)
            file:close()
        end
    end

    vim.cmd("edit " .. vim.fn.fnameescape(filepath))
end

return M
