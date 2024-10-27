# https://fishshell.com/docs/current/interactive.html#command-line-editor
function fish_hybrid_key_bindings --description \
    "Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr --add ghg git --no-pager log -n 1 --format=%H%n --grep
    abbr --add glom git log origin/main..HEAD
    abbr --add gnom git log --name-only origin/main..HEAD
    abbr --add reload source ~/.config/fish/config.fish

    fish_config theme choose Nord

    set -g fish_key_bindings fish_hybrid_key_bindings
    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace underscore blink
    set fish_cursor_replace_one underscore blink
    set fish_tmux_autostart true

    starship init fish | source
end
