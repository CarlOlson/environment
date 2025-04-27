set -gx ALTERNATE_EDITOR ""
set -gx EDITOR (which emacsclient)
set -gx FZF_CTRL_T_COMMAND fd --type f
set -gx FZF_DEFAULT_COMMAND fd --type f
set -gx HEX_HTTP_CONCURRENCY 1
set -gx HEX_HTTP_TIMEOUT 60
set -gx SPELL aspell -x -c
set -gx TMUX_TMPDIR /tmp
set -gx BAT_THEME base16
set -gx LC_TIME en_US.UTF-8
set -gx CUDA_VISIBLE_DEVICES 0
set -gx RIPGREP_CONFIG_PATH "$HOME/git/environment/dotfiles/.ripgreprc"

if test "$INSIDE_EMACS" = 'vterm'
    set -gx SUDO_EDITOR (which emacsclient)
else
    set -gx SUDO_EDITOR (which nano)
end

if test -d $HOME/.cargo/bin
    fish_add_path --path $HOME/.cargo/bin
end

if test -d /usr/local/go/bin
    fish_add_path --path /usr/local/go/bin
end

if test -n "$HOME" -a -n "$USER"
    set -l NIX_LINK $HOME/.nix-profile
    set -l NIX_USER_PROFILE_DIR /nix/var/nix/profiles/per-user/$USER
    set -gx NIX_PATH $NIX_PATH $HOME/.nix-defexpr/channels
    set -gx NIX_PROFILES /nix/var/nix/profiles/default $HOME/.nix-profile

    if test -e "/etc/ssl/certs/ca-certificates.crt" # NixOS, Ubuntu, Debian, Gentoo, Arch
        set -gx NIX_SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
    else if test -e "$NIX_LINK/etc/ssl/certs/ca-bundle.crt" # fallback
        set -gx NIX_SSL_CERT_FILE "$NIX_LINK/etc/ssl/certs/ca-bundle.crt"
    end

    if test -n "$MANPATH"
        set -gx MANPATH "$NIX_LINK/share/man:$MANPATH"
    end

    fish_add_path --path $NIX_LINK/bin
end
