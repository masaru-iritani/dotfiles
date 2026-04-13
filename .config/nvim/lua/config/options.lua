-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Force the project root to be the repository root. This prevents LazyVim
-- from diving into individual Go modules or workspaces within monorepo.
vim.g.root_spec = { ".git" }

vim.opt.guicursor = {
  "n-v-c-sm:blinkon500-blinkoff500",
  "i-ci-ve:ver50-blinkon500-blinkoff500",
  "r-cr-o:hor20",
}
