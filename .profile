export BROWSER=qutebrowser
export VISUAL=nvim
export EDITOR=nvim
export SUDO_EDITOR=nvim
export TERMINAL=alacritty

export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

## EXTERNAL CONFIG ##
export CM_LAUNCHER=rofi # clipmenud
export ZEIT_DB="$HOME/.config/zeit.db"
export ANDROID_SDK_ROOT="$HOME/Library/Android/Sdk"
export ANDROID_HOME="$HOME/Android/Sdk"
export DOTNET_ROOT=/usr/share/dotnet

export FZF_DEFAULT_OPTS="--cycle --preview 'bat --color=always --style=numbers --line-range=:500 {} 2>/dev/null || tree -L 2 -a --noreport {} | bat -l sh'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
 --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
 --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
 --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
 --color=selected-bg:#45475A \
 --color=border:#6C7086,label:#CDD6F4"

# Locale
# solve "Failed to set locale" https://www.linuxquestions.org/questions/showthread.php?s=340f6c86d1b4b6c0cf2275b109c261fa&p=6159694#post6159694
export LC_ALL="en_US.UTF-8"

## PATH ##
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$DOTNET_ROOT"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.scripts"
export PATH="$PATH:$HOME/.config/composer/vendor/bin/"
export PATH="$PATH:$HOME/.cargo/bin/"
export PATH="$PATH:$HOME/.local/bin/"
export PATH="$PATH:$HOME/go/bin/"
export PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin/"

export MOZ_ENABLE_WAYLAND=1
export MOZ_GDK_SCALE=1
