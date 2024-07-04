set -l FISH_DIR "$HOME/git/environment/fish"

if test -d "$HOME/anaconda3"
    source "$FISH_DIR/conda.fish"
else if test -d "$HOME/miniconda3"
    source "$FISH_DIR/conda2.fish"
end

source "$FISH_DIR/functions.fish"
source "$FISH_DIR/shortcuts.fish"
source "$FISH_DIR/variables.fish"
source "$FISH_DIR/wsl2.fish"
source "$FISH_DIR/sg.fish"

if test -f "$HOME/.asdf/asdf.fish"
  source "$HOME/.asdf/asdf.fish"
  source "$HOME/.asdf/completions/asdf.fish"
end

if test -f "$HOME/.opam/opam-init/init.fish"
  source "$HOME/.opam/opam-init/init.fish"
end

if isatty stdout
  bind -k sright forward-word
  bind -k sleft backward-word
end
