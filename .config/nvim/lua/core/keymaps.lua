-------------------------------------------------------------
--My key maps
-------------------------------------------------------------

local map = vim.keymap.set

map("n", "<leader>n", ":ene <BAR> startinsert <CR>", { desc = "New File" })
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 1 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Disable arrow keys
map({ "n", "v", "i" }, "<up>", "<nop>")
map({ "n", "v", "i" }, "<down>", "<nop>")
map({ "n", "v", "i" }, "<left>", "<nop>")
map({ "n", "v", "i" }, "<right>", "<nop>")

-- Telescope
map("n", "<leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "Find: Files" })
map("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>", { desc = "Find: Grep" })
map("n", "<leader>fc", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find: Grep Within Current Buffer" })
map("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Find: Buffers" })
map("n", "<leader>fr", "<Cmd>Telescope oldfiles<CR>", { desc = "Find: Recent Files" })
map("n", "<leader>fm", "<Cmd>Telescope man_pages<CR>", { desc = "Find: Man Pages" })

---- Normal mode
map("n", "<Leader>w", "<c-w>", { desc = "Window Options" })
map("n", "<Leader>q", ":wq<CR>", { desc = "Save Then Exit" })
map("n", "<Leader>x", ":q<CR>", { desc = "Exit" })

-- Using H/L to go to the begining and the end of line
map("n", "H", "_", { desc = "Start of the line" })
map("n", "L", "$", { desc = "End of the line" })

-- Leaping
map("n", "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
map("n", "S", "<Plug>(leap-backward)", { desc = "Leap backward" })

-- CheatSheet
map("n", "<leader>?", ":Cheatsheet<CR>", { desc = "Open CheatSheet" })

-- Windows
map("n", "<leader>v", ":vsplit<CR>", { desc = "Open Vertical Split" })
map("n", "<leader>h", ":split<CR>", { desc = "Open Horizontal Split" })

map("n", "<leader>q", "<Cmd>wq<CR><CR>", { desc = "Close Buffer" })

-- Comments
map("n", "<leader>/", "gcc", { desc = "Toggle Comments" })

-- Indent
map("v", "<", "<gv", { desc = "Indent Line" })
map("v", ">", ">gv", { desc = "Indent Line" })

-- Buffers

map("n", "J", "<Cmd>bp<CR>", { desc = "Go to previous Buffer" })
map("n", "K", "<Cmd>bn<CR>", { desc = "Go to Next Buffer" })

map("n", "<A-1>", "<Cmd>LualineBuffersJump! 1<CR>", { desc = "Go to Buffer 1" })
map("n", "<A-2>", "<Cmd>LualineBuffersJump! 2<CR>", { desc = "Go to Buffer 2" })
map("n", "<A-3>", "<Cmd>LualineBuffersJump! 3<CR>", { desc = "Go to Buffer 3" })
map("n", "<A-4>", "<Cmd>LualineBuffersJump! 4<CR>", { desc = "Go to Buffer 4" })
map("n", "<A-5>", "<Cmd>LualineBuffersJump! 5<CR>", { desc = "Go to Buffer 5" })
map("n", "<A-6>", "<Cmd>LualineBuffersJump! 6<CR>", { desc = "Go to Buffer 6" })
map("n", "<A-7>", "<Cmd>LualineBuffersJump! 7<CR>", { desc = "Go to Buffer 7" })
map("n", "<A-8>", "<Cmd>LualineBuffersJump! 8<CR>", { desc = "Go to Buffer 8" })
map("n", "<A-9>", "<Cmd>LualineBuffersJump! 9<CR>", { desc = "Go to Buffer 9" })
map("n", "<A-0>", "<Cmd>LualineBuffersJump! $<CR>", { desc = "Go to Last Buffer" })

-- Select all text in the current buffer
map("n", "<leader>C", "ggVG<cr>", { desc = "Select all text" })

-- Change split orientation
map("n", "<leader>th", "<C-w>t<C-w>K", { desc = "Change Vertical to Horizontal" })
map("n", "<leader>tv", "<C-w>t<C-w>H", { desc = "Change Horizontal to Vertical" })

-- Reload configuration without restart nvim
map("n", "<leader>r", ":so %<CR>", { desc = "Reload Configuration" })

-- Toggle Tagbar
map("n", "<leader>tb", "<Cmd>Vista!!<CR>", { desc = "Toggle TagBar" })

-- Resize Windows
map("n", "=", "<cmd>horizontal resize +5<cr>", { desc = "Resize Window Up" })
map("n", "-", "<cmd>horizontal resize -5<cr>", { desc = "Resize Window Down" })
map("n", "+", "<cmd>vertical resize +5<cr>", { desc = "Resize Window Left" })
map("n", "_", "<cmd>vertical resize -5<cr>", { desc = "Resize Window Right" })

-- Navigate Windows
map("n", "<A-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<A-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<A-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<A-l>", "<C-w>l", { desc = "Window Right" })

-- Undo Tree
map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree" })

-- LSP Mappings

map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP: Rename" })
map("n", "<F2>", "<nop>")
map("n", "<leader>lm", vim.lsp.buf.format, { desc = "LSP: Format" })
map("n", "<F3>", "<nop>")
map("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
map("n", "<F4>", "<nop>")
map("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "LSP: Type Definition" })
map("n", "go", "<nop>")
map("n", "<leader>lf", vim.lsp.buf.references, { desc = "LSP: Find References" })
map("n", "gr", "<nop>")

map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "gl", vim.diagnostic.open_float, { desc = "Open Float" })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Goto Next Diagnostic" })

map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle Terminal" })
map("n", "<C-S-k>", "<cmd>tabnext<CR>", { desc = "Tab: Next" })
map("n", "<C-S-j>", "<cmd>tabprevious<CR>", { desc = "Tab: Previous " })
map("n", "<leader><tab>n", "<cmd>tabnew<CR>", { desc = "Tab: New" })
