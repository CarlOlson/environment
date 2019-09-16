ZSHDIR=$0:A:h

fpath=(
    "$ZSHDIR/functions"
    $fpath
)

ZSH_THEME="sunrise"

CASE_SENSITIVE="false"

HYPHEN_INSENSITIVE="true"

DISABLE_AUTO_UPDATE="true"

COMPLETION_WAITING_DOTS="true"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

plugins=(git wd colored-man-pages kubectl zsh-autosuggestions zsh-syntax-highlighting zce docker)

source $ZSH/oh-my-zsh.sh
source $0:A:h/.zsh_variables
source $0:A:h/.zsh_funcs
source $0:A:h/.zsh_aliases

# add process return value to sunrise prompt
PROMPT='%B$PROMPTPREFIX %2~ %(?..%{$fg[red]%}%?%{$RESET%}) $(custom_git_prompt)%{$M%}%B»%b%{$RESET%} '

# disable rprompt, it doesnt play nice with emacs
RPROMPT=''

bindkey -e
bindkey '^g' forward-char
bindkey '^b' backward-char
bindkey '^[,' zce

bindkey '^ud' delete-word
bindkey '^uh' backward-delete-word
bindkey '^u/' which-command
bindkey "^uf" fzf-file-widget
bindkey "^u^f" fzf-cd-widget
bindkey "^r" fzf-history-widget

# for Emacs
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[h' backward-delete-word
bindkey '^[d' delete-word

autoload -U zmv

setopt DVORAK
setopt EXTENDED_GLOB
setopt COMPLETE_IN_WORD
setopt HIST_REDUCE_BLANKS
setopt MENU_COMPLETE

[ $TERM = "dumb" ] && unsetopt zle && PS1='$ '

autoload -Uz compinit
compinit
