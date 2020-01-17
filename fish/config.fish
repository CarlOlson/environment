set -l FISH_DIR "$HOME/git/environment/fish"
set -g PATH $HOME/.nix-profile/bin $PATH
set -g NIX_PATH $HOME/.nix-defexpr/channels
set -g NIX_PROFILES /nix/var/nix/profiles/default $HOME/.nix-profile
set -g NIX_SSL_CERT_FILE $HOME/.nix-profile/etc/ssl/certs/ca-bundle.crt

source "$FISH_DIR/functions.fish"
source "$FISH_DIR/shortcuts.fish"
source "$FISH_DIR/variables.fish"

if test -f "$HOME/.asdf/asdf.fish"
  source "$HOME/.asdf/asdf.fish"
  source "$HOME/.asdf/completions/asdf.fish"
end
