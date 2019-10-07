# misc
abbr --add s sudo
abbr --add cat bat
alias ns="nix-shell --command 'exec fish; return'"

# file location
abbr --add find find -mount
alias fd='fd --exclude=/mnt --exclude=/dev --exclude=/sys'
alias ls='lsd --classify'
alias la='lsd --classify --almost-all'
alias  l='lsd --classify --almost-all --long'
alias lr='lsd --classify --almost-all --long --date relative'

# tree commands
alias tree='lsd --tree'
abbr --add t tree --depth=2
abbr --add tt tree --depth=3
abbr --add ttt tree --depth=4
abbr --add tttt tree --depth=5

# git
abbr --add ga 'git add'
abbr --add gc 'git commit'
abbr --add gco 'git checkout'
abbr --add gd 'git diff'
abbr --add gl 'git pull'
abbr --add gp 'git push'
abbr --add gs 'git status'
abbr --add gst 'git stash'

abbr --add gap 'git add -p'
abbr --add gara 'git commit --amend --reset-author --no-edit'
abbr --add gcm 'git commit -m'
abbr --add gi 'git update-index --skip-worktree'
abbr --add glu 'git pull upstream HEAD'
abbr --add glup 'glu && git push'
abbr --add gnuke 'git clean -xfd'
abbr --add godel 'git origin --delete'
abbr --add grra 'git rebase -i --exec "git commit --no-edit --amend --author=carl"'
abbr --add gruh 'git reset --hard upstream HEAD'
abbr --add gstp 'git stash pop'
abbr --add gudel 'git upstream --delete'

# emacs
abbr --add ect emacsclient -tty
abbr --add ecw emacsclient --create-frame
alias emacs_tangle_init='emacs -Q -nw --load ~/git/environment/pre-tangle.el --file ~/git/environment/init.org -f org-babel-tangle -f kill-emacs'

# multimedia
abbr --add lain 'say -v whisper "present day, present time."'
abbr --add mpv mpv --demuxer-readahead-secs=60
abbr --add ffmpeg ffmpeg -loglevel warning -hide_banner

# weather
abbr --add  w curl wttr.in/Kyoto\?format=3
abbr --add ww curl wttr.in/Kyoto\?format=v2

# k8s, docker
abbr --add k kubectl
abbr --add dockly npx dockly
alias drun='docker run --rm -ti'
