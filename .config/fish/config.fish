set fish_greeting
eval "$(zoxide init fish --cmd cd)"
eval "$(starship init fish)"
navi widget fish | source

alias lgit="lazygit"
alias cls="clear"
alias copy="wl-copy"
alias ls="eza --icons=auto"
alias lt="eza --tree --level=3 --icons=auto"
alias l="eza -l --icons=auto"
alias logout="loginctl terminate-session self"
alias v='neovide'
alias vim="nvim"
alias nv='nvim'
alias rm="rip"
alias cat="bat"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias restore="$HOME/.local/share/Trash/files" #Trashed files directory
alias back="trash-restore"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias ......="cd ../../../../../"
alias sudo="doas"
alias suspend="systemctl suspend"
alias cheat="navi"
alias ff="fzf"
alias py="python"
alias cff="cd (fd -H --type directory | ff)"
alias man='batman'

set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux GRAVEYARD ~/.local/share/Trash
set -gx SHELL /usr/bin/fish
set -gx FZF_DEFAULT_OPTS "--border \
  --color fg:#5d6466,bg:#1e2527
  --color bg+:#ef7d7d,fg+:#2c2f30
  --color hl:#dadada,hl+:#26292a,gutter:#1e2527
  --color pointer:#373d49,info:#606672
  --border
  --color border:#1e2527
  --height 13'
  --preview 'bat --style=numbers --color=always --line-range :500 {}'"

fish_add_path /home/user/.cargo/bin
fish_add_path /home/user/.local/bin

function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

thefuck --alias | source
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
export BAT_THEME="Nord"
