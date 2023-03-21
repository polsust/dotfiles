-- require("")

vim.cmd([[
  imap <silent><script><expr> <C-f> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true
]])
