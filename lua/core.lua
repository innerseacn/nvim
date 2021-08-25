local disable_distribution_plugins = function()
  vim.g.loaded_gzip = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1
end

local load_core = function()
  disable_distribution_plugins()
  vim.g.mapleader = ","

  require("options")
  require("mapping")

  ---- packer commands ----
  vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
  vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
  vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
  vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
  vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

  ---- autocmds ----
  vim.cmd [[augroup INNERSEA
      autocmd!
      autocmd BufEnter * normal `"
      autocmd TextYankPost * lua vim.highlight.on_yank {higroup='IncSearch',timeout=150}
    augroup END]]

end

load_core()
