if status is-interactive
    # Commands to run in interactive sessions can go here
    function fish_user_key_bindings
        for mode in insert default visual
            bind -M $mode \cf forward-char
        end
    end

    function fish_mode_prompt
        switch $fish_bind_mode
            case default
                echo -en "\e[2 q"
                set_color -o brwhite
                echo "[ "
                set_color -o brred
                echo N
                set_color -o brwhite
                echo " ]"
            case insert
                echo -en "\e[6 q"
                set_color -o brwhite
                echo "[ "
                set_color -o brgreen
                echo I
                set_color -o brwhite
                echo " ]"
            case replace_one
                echo -en "\e[4 q"
                set_color -o brwhite
                echo "[ "
                set_color -o bryellow
                echo R
                set_color -o brwhite
                echo " ]"
            case visual
                echo -en "\e[2 q"
                set_color -o brwhite
                echo "[ "
                set_color -o brmagenta
                echo V
                set_color -o brwhite
                echo " ]"
            case '*'
                echo -en "\e[2 q"
                set_color -o brwhite
                echo "[ "
                set_color -o brred
                echo "?"
                set_color -o brwhite
                echo " ]"
        end
        set_color normal
    end

    # ENV Variables
    export VISUAL=nvim
    export EDITOR=nvim
    export SUDO_EDITOR=nvim

    # Locale
    # solve "Failed to set locale" https://www.linuxquestions.org/questions/showthread.php?s=340f6c86d1b4b6c0cf2275b109c261fa&p=6159694#post6159694
    export LC_ALL="en_US.UTF-8"

    ### PATH ###
    export PATH="$(yarn global bin):$PATH"
    export PATH="$HOME/.scripts:$PATH"
    export PATH="$HOME/.emacs.d/bin:$PATH"

    ### ALIASES ####
    alias f editFinder
    alias .2 "cd ../.."
    alias ll "ls -lt"
    alias ls "lsd --color=auto"
    alias cat bat
    alias psgrep "ps -e | grep -i"
    alias xclass "xprop | grep CLASS"
    alias e exit
    # function dotadd
    #     set -l absoluteFilePath "$(pwd)"
    #     set -l insideHomeFilePath (string split "$USER/" -- $absoluteFilePath)[2]
    #     command mv $argv "~/.dotfiles/$insideHomeFilePath"
    # end

    # dnf
    alias dnfi "sudo dnf install"
    alias dnfr "sudo dnf remove"
    alias dnfu "sudo dnf update"

    # git
    alias gitc "git commit -m"
    alias gits "git status"

    # apps
    alias scim sc-im
    alias rm trash-put
    alias rmdir trash-put
    alias r ranger
    alias z zathura

    ### END ALIASES ###

    # select a random fish
    set -lx fish_number (random 1 6)
    # print the random fish 
    /bin/cat ~/.config/fish/ascii/fish$fish_number | lolcat

end
