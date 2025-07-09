if status is-interactive
    fish_vi_key_bindings
    fish_vi_cursor 

    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind y fish_clipboard_copy
    bind p fish_clipboard_paste
    bind P fish_clipboard_paste

    function fish_mode_prompt; end # remove vi indicator
    bind -M insert \cf accept-autosuggestion

    ### ALIASES ####
    alias n notes
    alias c conf
    alias .2 "cd ../.."
    alias ll "ls -lt"
    alias ls "lsd --color=auto"
    alias cp "advcp -g"
    alias mv "advmv -g"
    alias cat bat
    alias psgrep "ps -e | grep -i"
    alias xclass "xprop | grep CLASS"
    alias e exit
    alias restart-qtile "qtile cmd-obj -o cmd -f restart"
    alias hfzf "history -n 1000 | fzf | xargs -I {} fish -ic "{}""
    alias rgf "rg --files | rg"
    alias cdwindows "cd /mnt/c/Users/psust/"

    # paru 
    alias I "paru -S"
    alias R "paru -R"
    alias U "paru -Syu"

    # dnf
    alias dnfi "sudo dnf install"
    alias dnfr "sudo dnf remove"
    alias dnfu "sudo dnf update"

    # git
    alias dotfiles "git -C ~/.dotfiles/"

    # apps
    alias scim sc-im
    alias rm trash-put
    alias rmdir trash-put
    alias r ranger
    alias z zathura
    alias lg lazygit
    alias nv nvim
    alias logout "pkill -KILL -u $USER"

    ### END ALIASES ###

    # select a random fish
    set -lx fish_number (random 1 (/bin/ls ~/.config/fish/ascii/ | count))
    # print the random fish 
    # /bin/cat ~/.config/fish/ascii/fish$fish_number | lolcat
    # Remove greeting
    set fish_greeting

end

zoxide init --cmd cd fish | source
