set fish_greeting
eval "$(zoxide init fish)"
eval "$(starship init fish)"

alias lgit="lazygit"
alias cls="clear"
alias ls="eza"
alias lt="eza --tree --level=3"
alias l="eza -l"
alias logout="loginctl terminate-session self"
alias vim="nvim"
alias v="nvim"
alias cd="z"
alias rm="rip"
alias cat="bat"
alias rrepl="evcxr"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias restore="$HOME/.local/share/Trash/files" #Trashed files directory
alias back="trash-restore"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias ......="cd ../../../../../"
alias sudo="doas"
alias cursed-timer=~/projects/github/cursed-timer/target/debug/cursed-timer

set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux GRAVEYARD ~/.local/share/Trash

fish_add_path /home/user/.cargo/bin

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
set -Ux FZF_DEFAULT_OPTS '
    --color=fg:#bbc3d4,bg:#242933,hl:#ebcb8b
    --color=fg+:#bbc3d4,bg+:#242933,hl+:#ebcb8b
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'


if status is-interactive
    # Commands to run in interactive sessions can go here
end
