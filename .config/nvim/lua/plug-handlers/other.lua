-- TODO C
-- colorizer, zen-mode
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"},
                            {pattern = "*.md", command = "set syntax=markdown"})
