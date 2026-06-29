local M = {}

local config = require("notesmd.config")
local inbox = require("notesmd.inbox")
local journal = require("notesmd.journal")
local prose = require("notesmd.prose")
local stamp = require("notesmd.stamp")
local vault = require("notesmd.vault")

local cmdlist = {
    journal = function()
        journal.open("journal")
    end,

    prose = function()
        prose.create("prose")
    end,

    vault = function()
        vault.create("vault")
    end,

    inbox = function()
        inbox.create("inbox")
    end,

    completestamp = function()
        stamp.complete()
    end,

    uploadstamp = function()
        stamp.upload()
    end,
}

---@param opts? NotesMDOptions
function M.setup(opts)
    config.setup(opts or {})

    local keymaps = config.options.keymaps

    if keymaps then
        for name, lhs in pairs(keymaps) do
            local keymap = cmdlist[name]

            if keymap then
                vim.keymap.set("n", lhs, keymap, {
                    desc = "NotesMD " .. name,
                })
            end
        end
    end
end

vim.api.nvim_create_user_command("NotesMD", function(opts)
    local cmd = cmdlist[opts.fargs[1]]

    if cmd then
        cmd()
    else
        vim.notify(
            ("Unknown NotesMD command: %s"):format(opts.fargs[1]),
            vim.log.levels.ERROR
        )
    end
end, {
    nargs = 1,

    complete = function()
        return vim.tbl_keys(cmdlist)
    end,
})

return M
