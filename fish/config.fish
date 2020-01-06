set -l FISH_DIR "$HOME/git/environment/fish"

source "$FISH_DIR/functions.fish"
source "$FISH_DIR/shortcuts.fish"
source "$FISH_DIR/variables.fish"

if test -f "$HOME/.asdf/asdf.fish"
  source "$HOME/.asdf/asdf.fish"
  source "$HOME/.asdf/completions/asdf.fish"
end
