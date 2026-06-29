local config = require("notesmd.config")

local M = {}

local function check_notes_dir()
    local notes_dir = config.options.notes_dir

    if type(notes_dir) ~= "string" or notes_dir == "" then
        vim.health.error("notes_dir is not configured", {
            [[Add notes_dir to your setup:]],
            [[require("notesmd").setup({]],
            [[    notes_dir = vim.fn.expand("~/notes"),]],
            [[})]],
        })
        return
    end

    vim.health.ok("notes_dir is configured: " .. notes_dir)

    if vim.fn.isdirectory(notes_dir) == 1 then
        vim.health.ok("notes_dir exists")
    else
        vim.health.warn("notes_dir does not exist yet: " .. notes_dir, {
            "notesmd.nvim will create note type directories when creating notes.",
            "Make sure the parent path is correct.",
        })
    end
end

local function check_types()
    local required_types = {
        "journal",
        "prose",
        "vault",
        "inbox",
    }

    for _, name in ipairs(required_types) do
        local note_type = config.get_type(name)

        if note_type then
            vim.health.ok(("type '%s' is configured"):format(name))

            if type(note_type.dir) == "string" and note_type.dir ~= "" then
                vim.health.ok(("type '%s' dir: %s"):format(name, note_type.dir))
            else
                vim.health.error(("type '%s' has no valid dir"):format(name))
            end
        else
            vim.health.warn(("type '%s' is not configured"):format(name))
        end
    end
end

local function check_keymaps()
    local keymaps = config.options.keymaps

    if not keymaps then
        vim.health.info("No keymaps configured")
        return
    end

    local commands = {
        journal = true,
        prose = true,
        vault = true,
        inbox = true,
        completestamp = true,
        uploadstamp = true,
    }

    for name, lhs in pairs(keymaps) do
        if commands[name] then
            vim.health.ok(("keymap '%s' -> %s"):format(name, lhs))
        else
            vim.health.warn(("unknown keymap command: %s"):format(name))
        end
    end
end

function M.check()
    vim.health.start("notesmd.nvim")

    check_notes_dir()
    check_types()
    check_keymaps()
end

return M
