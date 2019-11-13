set -gx ALTERNATE_EDITOR ""
set -gx EDITOR emacsclient
set -gx FZF_CTRL_T_COMMAND fd --type f
set -gx FZF_DEFAULT_COMMAND fd --type f
set -gx HEX_HTTP_CONCURRENCY 1
set -gx HEX_HTTP_TIMEOUT 60
set -gx SPELL aspell -x -c
set -gx PATH $HOME/git/scripts $PATH
set -gx TMUX_TMPDIR /tmp

if test -d /mnt/c
    set -gx PATH $HOME/.nix-profile/bin $PATH
    set -gx NIX_PATH $HOME/.nix-defexpr/channels
    set -gx NIX_PROFILES /nix/var/nix/profiles/default $HOME/.nix-profile
    set -gx NIX_SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt

    set -l ip (rg -N 'nameserver (.*)' -r '$1' /etc/resolv.conf)
    set -gx DISPLAY $ip:0.0
end
