# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

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

# history manager
eval "$(atuin init zsh)"

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

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

alias ls="eza --color=always --long --no-time --no-user --no-permissions --group-directories-first --total-size"
alias cat="bat"
