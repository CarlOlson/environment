if status is-interactive
    if test "$INSIDE_EMACS" = 'vterm'
        set -gx EDITOR (which emacsclient)
        set -gx SUDO_EDITOR (which emacsclient)
    else if isatty stdout
        bind shift-right forward-word
        bind shift-left backward-word
    end

    set -l FISH_DIR "$HOME/git/environment/fish"
    source "$FISH_DIR/shortcuts.fish"
    source "$FISH_DIR/functions.fish"
end
