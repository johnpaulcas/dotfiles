-- Convert tabs to spaces
vim.opt.expandtab = true -- Use spaces instead of tab characters
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 4 -- Number of spaces a <Tab> feels like when editing
vim.opt.smarttab = true -- Makes tabbing smarter, will insert shiftwidth spaces
vim.opt.smartindent = true -- Makes indenting smart (for things like { })
vim.opt.autoindent = true -- Auto-indents new lines to match previous line
vim.opt.guicursor = ""

-- Line numbering
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- UI & Interaction
vim.opt.showmode = false -- Don't show mode since statusline will handle it
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.cursorline = true -- Highlight the line under the cursor

-- Indentation display
vim.opt.breakindent = true -- Enable break indent (for wrapped lines)

-- Undo
vim.opt.undofile = true -- Save undo history even after closing files

-- Search behavior
vim.opt.ignorecase = true -- Case-insensitive search by default...
vim.opt.smartcase = true -- ...but case-sensitive if uppercase letters used

-- UI Layout
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below

-- Whitespace rendering
vim.opt.list = true -- Show hidden characters like tabs, trailing spaces
vim.opt.listchars = {
	tab = "» ", -- Display tabs as "» "
	trail = "·", -- Display trailing spaces as dots
	nbsp = "␣", -- Display non-breaking space
}

vim.opt.cmdheight = 0

-- Scrolling behavior
vim.opt.scrolloff = 10 -- Keep 8 lines visible above/below cursor

-- Default all yank/paste to system clipboard
vim.opt.clipboard = "unnamedplus"
