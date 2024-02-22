set fish_greeting
eval "$(zoxide init fish --cmd cd)"
eval "$(starship init fish)"

alias lgit="lazygit"
alias cls="clear"
alias copy="wl-copy"
alias ls="eza"
alias lt="eza --tree --level=3"
alias l="eza -l"
alias logout="loginctl terminate-session self"
alias vim="nvim"
alias v="nvim"
alias nvim='nvim --startuptime /tmp/nvim-startuptime'
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
alias suspend="systemctl suspend"
alias cheat="navi"
alias ff="fzf"

set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux GRAVEYARD ~/.local/share/Trash

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
set -Ux FZF_DEFAULT_OPTS '
    --color=fg:#bbc3d4,bg:#242933,hl:#ebcb8b
    --color=fg+:#bbc3d4,bg+:#242933,hl+:#ebcb8b
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'


if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -l foreground c0caf5
set -l selection 283457
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection
