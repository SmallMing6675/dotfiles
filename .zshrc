# Sources:
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh 
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(/usr/bin/starship init zsh --print-full-init)

# Autocomplete
eval "$(~/.local/bin/zoxide init zsh)"
autoload -U compinit; compinit
zstyle -e ':autocomplete:list-choices:*' list-lines 'reply=($(( LINES / 3 )))' format 
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}➜ %d %f'

PATH=$PATH:~/.local/bin/:~/.cargo/bin/

# Aliases
alias cls="clear"
alias ls="eza"
alias lt="eza --tree --level=4"
alias l="eza -l"
alias logout="loginctl terminate-session self"
alias obsidian="~/AppImage/Obsidian-1.4.16.AppImage"
alias vim="nvim"
alias cat="bat"
alias sudo="doas"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cd="z"
alias ...="../../"
alias ....="../../../"

export EDITOR="nvim"

GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

