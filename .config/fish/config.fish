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
alias cat="bat"
alias rrepl="evcxr"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias rm="safe-rm"
alias restore="$HOME/.local/share/Trash/files" #Trashed files directory
alias back="trash-restore"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias ......="cd ../../../../../"

set -Ux PATH $PATH:/home/user/.cargo/bin
set -Ux EDITOR nvim
set -Ux VISUAL nvim


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


if status is-interactive
    # Commands to run in interactive sessions can go here
end
