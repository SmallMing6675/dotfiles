export ZSH="$HOME/.local/share/oh-my-zsh"
source $ZSH/oh-my-zsh.sh


plugins=(
        colored-man-pages
        zsh-autosuggestions
        sudo
        ls
        copyfile
        archlinux
        git 
        pass
        autoenv
        command-not-found
        copypath
        fzf
        man
        thefuck
)

#autocomplete
autoload -U compinit; compinit
zstyle -e ':autocomplete:list-choices:*' list-lines 'reply=($(( LINES / 3 )))' format 
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}➜ %d %f'

PATH=$PATH:/usr/lib/ruby/gems/3.0.0/gems

# Sources:
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh 
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
source <(/usr/bin/starship init zsh --print-full-init)

export "MICRO_TRUECOLOR=1"
export BAT_THEME="Catppuccin-mocha"

#aliases
alias cls="clear"
alias ls="eza"
alias lt="eza --tree --level=3"
alias l="eza -l"
alias logout="loginctl terminate-session self"
alias obsidian="~/AppImage/Obsidian-1.4.16.AppImage"
alias hx="helix"
alias vim="nvim"
alias micro="nvim"
alias cat="bat"
alias sudo="doas"
alias yadm="yadm --yadm-repo ~/dotfiles"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


export EDITOR="nvim"
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
