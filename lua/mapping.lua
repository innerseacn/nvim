--[=[
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end
]=]

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

---- Normal ----
map("n", "<leader><leader>", ":noh<CR>", opts)
map('n', '<leader>mm', [[:lua require('material.functions').toggle_style()<CR>]], opts)
map("n", "H", "^", opts)
map("n", "L", "$", opts)
map("n", '<C-z>', 'o<ESC>', opts)
map("n", '<C-x>', 'O<ESC>', opts)
map("n", '<CR>', 'i<CR><ESC>', opts)
map('i', '<M-n>', '<C-n>', opts)
map('i', '<M-p>', '<C-p>', opts)

---- Write buffer (save) ----
map("n", "<C-s>", "<ESC>:w<CR>", opts)
map("n", "<C-q>", "<ESC>:q<CR>", opts)
map("i", "<C-h>", "<BS>", opts)
map("i", "<C-d>", "<Del>", opts)
map("i", "<C-s>", "<ESC>:w<CR>", opts)
map("i", "<C-q>", "<ESC>:x<CR>", opts)

---- switch window ----
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
-- map("n", "aj", ":Sayonara<CR>", opts)
map("n", "<M-p>", ":bp<CR>", opts)
map("n", "<M-n>", ":bn<CR>", opts)

---- bufferline ----
map("n", "<M-b>", ":BufferLinePick<CR>", opts)
map("n", "<M-c>", ":BufferLinePickClose<CR>", opts)
map("n", "<M-1>", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<M-2>", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<M-3>", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<M-4>", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<M-5>", ":BufferLineGoToBuffer 5<CR>", opts)
map("n", "<M-6>", ":BufferLineGoToBuffer 6<CR>", opts)
map("n", "<M-7>", ":BufferLineGoToBuffer 7<CR>", opts)
map("n", "<M-8>", ":BufferLineGoToBuffer 8<CR>", opts)
map("n", "<M-9>", ":BufferLineGoToBuffer 9<CR>", opts)

---- tree view ---- 
map("n", "\\", ":<C-u>NvimTreeToggle<CR>", opts)
map("n", "<Leader>F", ":<C-u>NvimTreeFindFile<CR>", opts)
--[=[
-- tab complete
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true, noremap = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {noremap = true, expr = true})
map(
  "i",
  "<CR>",
  [[compe#confirm({ 'keys': "<Plug>delimitMateCR", 'mode': '' })]],
  {noremap = true, expr = true}
)

map("i", "<C-e>", [[compe#close('<C-e>')]], {expr = true, noremap = true})
map("i", "<C-j>", "v:lua.tab_complete()", {expr = true, noremap = true})
map("i", "<C-k>", "v:lua.s_tab_complete()", {noremap = true, expr = true})
map("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {noremap = true, silent = true})
map("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {noremap = true, silent = true})

-- vsnip Expand or jump
map("i", "<C-n>", "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'", {expr = true})
map("s", "<C-n>", "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'", {expr = true})

-- Plugin Floaterm
map("n", "<A-d>", ":Lspsaga open_floaterm<CR>", opts)
map("t", "<A-d>", [[<C-\><C-n>:Lspsaga close_floaterm<CR>]], opts)
map("n", "<Leader>g", ":Lspsaga open_floaterm lazygit<CR>", opts)

-- fuzzyfind 模糊搜索 快捷键
map("n", "<Leader>bb", ":<C-u>Telescope buffers<CR>", opts)
map("n", "<Leader>fa", ":<C-u>Telescope live_grep<CR>", opts)
map("n", "<Leader>ff", ":<C-u>Telescope find_files<CR>", opts)
map("n", "<Leader>fh", ":<C-u>DashboardFindHistory<CR>", opts)

map("n", "<Leader>tf", ":<C-u>DashboardNewFile<CR>", opts)


-- Vista
map("n", "<Leader>v", ":<C-u>Vista!!<CR>", opts)

-- LSP
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
map("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
map("n", "gD", "<cmd>lua vim.lsp.buf.implementation<CR>", opts)
map("n", "gs", "<cmd>Lspsaga signature_help<CR>", opts)
map("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
map("n", "gw", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
map("n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
map("v", "ga", "<cmd>Lspsaga range_code_action<CR>", opts)
map("n", "<Leader>ce", "Lspsaga show_line_diagnostics", opts)

map("n", "j", "<Plug>(accelerated_jk_gj)", {silent = true})
map("n", "k", "<Plug>(accelerated_jk_gk)", {silent = true})

map('n', '<F5>', "<cmd>AsyncTask file-run<CR>", {})
map('n', '<F6>', "<cmd>AsyncTask project-run<CR>", {})
map('n', '<F7>', "<cmd>AsyncTask project-build<CR>", {})
map('n', '<F9>', "<cmd>AsyncTask file-build<CR>", {})
]=]
