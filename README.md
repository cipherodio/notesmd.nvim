---
title: NotesMD
author: Jeremy
description:  A small Neovim plugin for creating Markdown notes with configurable YAML frontmatter.
---

`notesmd.nvim` can create different note types such as:

- journal
- prose
- vault
- inbox

It can also stamp frontmatter fields like `completed` and `uploaded`.

## Installation

Using `vim.pack`:

```lua
vim.pack.add({
    { src = "https://github.com/cipherodio/notesmd.nvim" },
}, { confirm = false })
```

## Setup

```lua
require("notesmd").setup({
    notes_dir = vim.fn.expand("~/hub/src/mdnotes"),

    types = {
        journal = {
            dir = "journal",
            frontmatter = {
                fields = {
                    title = "Journal",
                    author = "Jeremy",
                    created = true,
                },
                sort_order = {
                    "title",
                    "author",
                    "created",
                },
            },
        },

        prose = {
            dir = "prose",
            frontmatter = {
                fields = {
                    title = "input",
                    author = "input",
                    created = true,
                    completed = "",
                    uploaded = "",
                    description = "input",
                },
                sort_order = {
                    "title",
                    "author",
                    "created",
                    "completed",
                    "uploaded",
                    "description",
                },
            },
        },

        vault = {
            dir = "vault",
            frontmatter = {
                fields = {
                    title = "input",
                    author = "input",
                    created = true,
                    description = "input",
                },
                sort_order = {
                    "title",
                    "author",
                    "created",
                    "description",
                },
            },
        },

        inbox = {
            dir = "inbox",
            frontmatter = {
                fields = {
                    title = "input",
                    author = "Jeremy",
                    created = true,
                    description = "input",
                },
                sort_order = {
                    "title",
                    "author",
                    "created",
                    "description",
                },
            },
        },
    },

    keymaps = {
        journal = "<leader>mj",
        prose = "<leader>mp",
        vault = "<leader>mv",
        inbox = "<leader>mi",
        completestamp = "<leader>mc",
        uploadstamp = "<leader>mu",
    },
})
```

## Commands

```vim
:NotesMD journal
:NotesMD prose
:NotesMD vault
:NotesMD inbox
:NotesMD completestamp
:NotesMD uploadstamp
```

## Field values

Fixed value:

```lua
author = "Jeremy"
```

Prompt for input:

```lua
title = "input"
```

Empty quoted field:

```lua
completed = ""
```

Created timestamp:

```lua
created = true
```

Custom timestamp format:

```lua
created = "%Y-%m-%d %H:%M"
```

## Healthcheck

```vim
:checkhealth notesmd
```

## Help

Full documentation is available inside Neovim:

```vim
:help notesmd
```

## License

MIT
