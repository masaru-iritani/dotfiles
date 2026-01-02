local vim_path = vim.fn.expand("~/.vim")

vim.opt.runtimepath:prepend(vim_path)
vim.opt.runtimepath:append(vim_path .. "/after")
vim.opt.packpath = vim.opt.runtimepath:get()

vim.cmd("source " .. vim.fn.expand("~/.vimrc"))
