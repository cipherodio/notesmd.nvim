---@alias NotesMDTextField string
---@alias NotesMDTimestampField boolean|string

---@class NotesMDFrontmatterFields
---@field title? NotesMDTextField
---@field author? NotesMDTextField
---@field description? NotesMDTextField
---@field created? NotesMDTimestampField
---@field completed? NotesMDTextField
---@field uploaded? NotesMDTextField

---@class NotesMDFrontmatter
---@field fields? NotesMDFrontmatterFields
---@field sort_order? string[]

---@class NotesMDType
---@field dir string
---@field frontmatter? NotesMDFrontmatter

---@class NotesMDOptions
---@field notes_dir? string
---@field types table<string, NotesMDType>
---@field keymaps? table<string, string>

local M = {}

---@type NotesMDOptions
M.options = {
    types = {
        journal = {
            dir = "journal",
            frontmatter = {
                fields = {},
                sort_order = {},
            },
        },

        prose = {
            dir = "prose",
            frontmatter = {
                fields = {},
                sort_order = {},
            },
        },

        vault = {
            dir = "vault",
            frontmatter = {
                fields = {},
                sort_order = {},
            },
        },

        inbox = {
            dir = "inbox",
            frontmatter = {
                fields = {},
                sort_order = {},
            },
        },
    },
}

---@param opts? NotesMDOptions
function M.setup(opts)
    M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

---@param name string
---@return NotesMDType?
function M.get_type(name)
    return M.options.types[name]
end

---@return string?
function M.notes_dir()
    local notes_dir = M.options.notes_dir

    if type(notes_dir) ~= "string" or notes_dir == "" then
        vim.notify("notesmd.nvim: notes_dir is not configured.", vim.log.levels.ERROR)
        return nil
    end

    return notes_dir
end

return M
