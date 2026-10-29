# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/oh-my-zsh"
[[ -r "$ZSH/oh-my-zsh.sh" ]] || ZSH=/usr/share/oh-my-zsh
ZSH_THEME=""
plugins=(git)
[[ ! -r "$ZSH/oh-my-zsh.sh" ]] || source "$ZSH/oh-my-zsh.sh"

if [[ -r "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/powerlevel10k/powerlevel10k.zsh-theme"
elif [[ -r /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

export PATH="$HOME/.dotnet/tools:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Kanagawa Dragon prompt colors; keep the existing prompt layout.
typeset -g POWERLEVEL9K_BACKGROUND='#282727'
typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND='#c5c9c5'
typeset -g POWERLEVEL9K_DIR_FOREGROUND='#8ba4b0'
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND='#a6a69c'
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='#8ea4a2'
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='#8a9a7b'
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='#8a9a7b'
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='#c4b28a'
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND='#8a9a7b'
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND='#8a9a7b'
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='#c4746e'
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND='#c4746e'
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND='#c4746e'
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='#c8c093'
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='#8ea4a2'

export LS_COLORS="${LS_COLORS}:ow=01;34:tw=01;34:st=01;34"

alias ls='eza --group-directories-first --icons=auto'
alias ll='eza --long --group-directories-first --icons=auto'
alias tree='eza --tree --level=2 --group-directories-first --icons=auto'
alias lg='lazygit'
