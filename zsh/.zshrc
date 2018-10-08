function _maybe_load() {
    if [ -e $1 ]; then
        source $1
    fi
}

ZSHDIR=$0:A:h

fpath=(
    "$ZSHDIR/functions"
    $fpath
)

PATH=$HOME/bin:$PATH

ZSH_THEME="sunrise"

CASE_SENSITIVE="false"

HYPHEN_INSENSITIVE="true"

DISABLE_AUTO_UPDATE="true"

COMPLETION_WAITING_DOTS="true"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

plugins=(git wd colored-man-pages sudo bundler)

_maybe_load $ZSH/oh-my-zsh.sh

_maybe_load /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

_maybe_load $0:A:h/.zsh_variables

_maybe_load $0:A:h/.zsh_funcs

_maybe_load $0:A:h/.zsh_aliases

function custom_nix_prompt() {
    if [ $IN_NIX_SHELL ]
    then
        echo "nix"$SHLVL" "
    fi
}

PROMPT='%B$PROMPTPREFIX %2~ $(custom_nix_prompt)$(custom_git_prompt)%{$M%}%B»%b%{$RESET%} '

RPROMPT='%(?..%{$fg[red]%}%?%{$RESET%})'

bindkey -e
bindkey '^g' forward-char
bindkey '^b' backward-word
bindkey '\ed' delete-word
bindkey '\eh' backward-delete-word
bindkey '\e/' which-command

autoload -U zmv

setopt DVORAK
setopt EXTENDED_GLOB
setopt COMPLETE_IN_WORD
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt MENU_COMPLETE

[ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
