CASE_SENSITIVE=false
COMPLETION_WAITING_DOTS=true
DISABLE_AUTO_UPDATE=true
HYPHEN_INSENSITIVE=true
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# add process return value to sunrise prompt
PROMPT='%B$PROMPTPREFIX %2~ %(?..%{$fg[red]%}%?%{$RESET%}) $(custom_git_prompt)%{$M%}%B»%b%{$RESET%} '

# disable rprompt, it doesnt play nice with emacs
RPROMPT=

source $HOME/git/environment/zsh/.zsh_variables
source $HOME/git/environment/zsh/.zsh_funcs
source $HOME/git/environment/zsh/.zsh_aliases

setopt COMPLETE_IN_WORD
setopt DVORAK
setopt EXTENDED_GLOB
setopt HIST_REDUCE_BLANKS
setopt MENU_COMPLETE

bindkey '^g' forward-char
bindkey '^b' backward-char
bindkey '^[,' zce

bindkey '^ud' delete-word
bindkey '^uh' backward-delete-word
bindkey '^u/' which-command
bindkey "^uf"  fzf-file-widget
bindkey "^u^f" fzf-cd-widget
bindkey "^r"   fzf-history-widget

# for Emacs
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[h' backward-delete-word
bindkey '^[d' delete-word

autoload -U zmv

[ $TERM = "dumb" ] && unsetopt zle && PS1='$ '

autoload -Uz compinit
compinit
