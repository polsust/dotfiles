vim.cmd([[highlight Headline1 guifg=#84aded]])
vim.cmd([[highlight Headline2 guifg=#eda484]])
vim.cmd([[highlight Headline3 guifg=#a7ed84]])
vim.cmd([[highlight Headline4 guifg=#eddf84]])
vim.cmd([[highlight Headline5 guifg=#e484ed]])

require("headlines").setup({
  markdown = {
    headline_highlights = {
      "Headline1",
      "Headline2",
      "Headline3",
      "Headline4",
      "Headline5",
    },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    dash_string = "-",
    quote_highlight = "Quote",
    quote_string = "┃",
    fat_headlines = false,
    fat_headline_upper_string = "▃",
    fat_headline_lower_string = "🬂",
  },
})
