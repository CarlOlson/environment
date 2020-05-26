set -gx ALTERNATE_EDITOR ""
set -gx EDITOR emacsclient
set -gx FZF_CTRL_T_COMMAND fd --type f
set -gx FZF_DEFAULT_COMMAND fd --type f
set -gx HEX_HTTP_CONCURRENCY 1
set -gx HEX_HTTP_TIMEOUT 60
set -gx SPELL aspell -x -c
set -gx PATH $HOME/git/scripts $PATH
set -gx TMUX_TMPDIR /tmp
set -gx BAT_THEME base16

if test -d /mnt/c
    set -l ip (rg -N 'nameserver (.*)' -r '$1' /etc/resolv.conf)
    set -gx DISPLAY $ip:0.0
end

if test -d "$HOME/.cargo/bin"
    set -gx PATH "$HOME/.cargo/bin" $PATH
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

    set -gx PATH "$NIX_LINK/bin:$PATH"
end
