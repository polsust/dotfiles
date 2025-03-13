local options = {
  backup = false,                                 -- creates a backup file
  clipboard = "unnamedplus",                      -- allows neovim to access the system clipboard
  cmdheight = 2,                                  -- more space in the neovim command line for displaying messages
  completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                               -- so that `` is visible in markdown files
  fileencoding = "utf-8",                         -- the encoding written to a file
  hlsearch = true,                                -- highlight all matches on previous search pattern
  ignorecase = true,                              -- ignore case in search patterns
  mouse = "a",                                    -- allow the mouse to be used in neovim
  pumheight = 10,                                 -- pop up menu height
  showmode = false,                               -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                                -- always show tabs
  smartcase = true,                               -- smart case
  smartindent = true,                             -- make indenting smarter again
  autoindent = true,
  splitbelow = true,                              -- force all horizontal splits to go below current window
  splitright = true,                              -- force all vertical splits to go to the right of current window
  swapfile = false,                               -- creates a swapfile
  termguicolors = true,                           -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                              -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                                -- enable persistent undo
  updatetime = 300,                               -- faster completion (4000ms default)
  writebackup = false,                            -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                               -- convert tabs to spaces
  shiftwidth = 2,                                 -- the number of spaces inserted for each indentation
  tabstop = 2,                                    -- insert 2 spaces for a tab
  cursorline = true,                              -- highlight the current line
  number = true,                                  -- set numbered lines
  relativenumber = true,                          -- set relative numbered lines
  numberwidth = 4,                                -- set number column width to 2 {default 4}
  signcolumn = "yes",                             -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                                    -- display lines as one long line
  linebreak = true,
  scrolloff = 8,                                  -- is one of my fav
  sidescrolloff = 8,
  guifont = "mononoki Nerd Font:h11",             -- the font used in graphical neovim applications
  spelllang = "fr-FR",
  foldmethod = "indent",
  foldexpr = "nvim_treesitter#foldexpr()",
  -- foldmethod = "expr",
}

vim.opt.shortmess:append("c")

vim.cmd([[
  set nofoldenable
  set foldlevel=99
  set fillchars=fold:\
  set foldtext=CustomFoldText()
  set foldmethod=expr
  set foldexpr=GetPotionFold(v:lnum)

  function! GetPotionFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
      return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
      return this_indent
    elseif next_indent < this_indent
      return this_indent
    elseif next_indent > this_indent
      return '>' . next_indent
    endif
  endfunction

  function! IndentLevel(lnum)
      return indent(a:lnum) / &shiftwidth
  endfunction

  function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
  endfunction

  function! CustomFoldText()
    " get first non-blank line
    let fs = v:foldstart

    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile

    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = 10
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
    return line . expansionString . foldSizeStr . foldLevelStr
    endfunction
]])

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.at_custom_alternates = {
  ["yes"] = "no",
  ["==="] = "!==",
  ["=="] = "!=",
  [">="] = "<=",
  ["private"] = "public",
  ["start"] = "end",
  ["desc"] = "asc",
  ["descend"] = "ascend",
  ["active"] = "inactive",
}

vim.cmd([[
  let g:neovide_scale_factor = 1
]])

vim.g.autosave = true

-- vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.cmd([[set iskeyword+=-]]) -- count "asdasd-asdasd-ad" as one word
-- vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work
