function nix-path() {
    nix-env -qab --out-path --no-name -A $1 | more
}

function _maybe_load() {
    if [ -e $1 ]; then
        source $1
    fi
}

fpath=("$HOME/.nix-profile/share/zsh/site-functions/" $fpath)

PATH=$HOME/bin:$HOME/.nix-profile/bin:$PATH

MANPATH="$HOME/.nix-profile/share/man:$MANPATH"

ZSH=`nix-path nixpkgs.oh-my-zsh`/share/oh-my-zsh

ZSH_THEME="sunrise"

ZSHDIR=$0:A:h

CASE_SENSITIVE="false"

HYPHEN_INSENSITIVE="true"

DISABLE_AUTO_UPDATE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git wd)

_maybe_load $ZSH/oh-my-zsh.sh

_maybe_load $0:A:h/.zsh_variables

_maybe_load $0:A:h/.zsh_funcs

_maybe_load $0:A:h/.zsh_aliases

_maybe_load $HOME/.nix-profile/etc/profile.d/nix.sh

_maybe_load `nix-path nixpkgs.zsh-syntax-highlighting`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

PROMPT='%B$PROMPTPREFIX %2~ $(git config --global user.name) $(custom_git_prompt)%{$M%}%B»%b%{$RESET%} '

bindkey -e
bindkey '^g' forward-char
bindkey '^b' backward-word

autoload -U zmv

setopt DVORAK
