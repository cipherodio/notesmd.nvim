local config = require("notesmd.config")
local fileformat = require("notesmd.utils.fileformat")
local frontmatter = require("notesmd.frontmatter")
local path = require("notesmd.utils.path")

local M = {}

---@param label string
---@return string
local function prompt(label)
    return vim.fn.input(label .. ": ")
end

---@param name string
function M.create(name)
    local note_type = config.get_type(name)
    if not note_type then
        return
    end

    local fm = note_type.frontmatter or {}
    local fields = vim.deepcopy(fm.fields or {})

    local title = fields.title or ""
    if title == "input" then
        title = prompt("Title")
    end

    local author = fields.author or ""
    if author == "input" then
        author = prompt("Author")
    end

    local description = fields.description or ""
    if description == "input" then
        description = prompt("Description")
    end

    local filename = prompt("Filename (leave blank to use title)")

    local root = config.notes_dir()
    if not root then
        return
    end

    local directory = path.join(root, note_type.dir)
    local final_filename = filename

    if final_filename == "" then
        final_filename = title
    end

    if final_filename == "" then
        vim.notify("Filename is required.", vim.log.levels.ERROR)
        return
    end

    local filepath = path.join(directory, fileformat.slugify(final_filename) .. ".md")

    vim.fn.mkdir(directory, "p")

    if vim.fn.filereadable(filepath) == 0 then
        if fields.title ~= nil then
            fields.title = title
        end

        if fields.author ~= nil then
            fields.author = author
        end

        if fields.description ~= nil then
            fields.description = description
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
