#! /usr/bin/env nix-shell
#! nix-shell -i bash -p nodejs_24

exec node "$HOME/git/rescript-vscode/server/out/cli.js" --stdio
