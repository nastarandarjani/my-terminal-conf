# Check system dark mode status
local is_dark=$(defaults read -g AppleInterfaceStyle 2>/dev/null)

if [[ "$is_dark" == "Dark" ]]; then
    eval "$(oh-my-posh init zsh --config ~/.config/ohmypush/frappe.omp.json)"
    osascript -e 'tell application "Terminal"
        set current settings of tabs of windows to settings set "catppuccin-frappe"
    end tell'
else
    eval "$(oh-my-posh init zsh --config ~/.config/ohmypush/latte.omp.json)"
    osascript -e 'tell application "Terminal"
        set current settings of tabs of windows to settings set "catppuccin-latte"
    end tell'
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# zsh-autocomplete config
bindkey              '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select
zstyle ':completion:*' list-rows-first no

# FZF
eval "$(fzf --zsh)"
export FZF_CTRL_T_COMMAND='fd --type f --max-depth 1 --one-file-system; fd --type d --hidden --strip-cwd-prefix --one-file-system --exclude .git --min-depth 2'

# Setup fzf previews
export FZF_CTRL_T_OPTS="
--height 50% --layout=default --border
--style=minimal
--prompt='❯ '

--preview '
if [ -d {} ]; then
  eza --icons=always --tree --color=always {} | head -50
else
  bat --decorations=always --color=always --theme auto:system -n --line-range :50 {}
fi
'"

# history manager
eval "$(atuin init zsh)"

#* Conda Setup
# export PATH=/usr/local/anaconda3/bin:$PATH
# export PATH=/opt/homebrew/anaconda3/bin:$PATH

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# ---- alias -----
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -n -l man --decorations=always'"

alias ls="eza --color=always --long --no-time --no-user --no-permissions --group-directories-first --total-size"
alias cat="bat --paging=never"
