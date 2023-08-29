require("wtf").setup({
  -- Default AI popup type
  popup_type = "popup", -- | "horizontal" | "vertical",
  -- ChatGPT Model
  openai_model_id = "gpt-3.5-turbo",
  -- Set your preferred language for the response
  language = "english",
  -- Any additional instructions
  -- additional_instructions = "Start the reply with 'OH HAI THERE'",
  -- Default search engine, can be overridden by passing an option to WtfSeatch
  default_search_engine = "duck_duck_go",
})

vim.g["wtf_hooks"] = {
  request_started = function()
    vim.cmd("hi StatusLine ctermbg=NONE ctermfg=yellow")
  end,
  request_finished = vim.schedule_wrap(function()
    vim.cmd("hi StatusLine ctermbg=NONE ctermfg=NONE")
  end),
}
