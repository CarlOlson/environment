# misc
abbr --add s sudo
alias ns="nix-shell --command 'exec fish; return'"

# file location
abbr --add find find -mount
alias fd='fd --exclude=/mnt --exclude=/dev --exclude=/sys'
alias ls='exa --classify --icons'
alias la='exa --classify --icons --all'
alias  l='exa --classify --icons --all --long --git'
alias lr='lsd --classify --almost-all --long --date relative'

# tree commands
alias tree='lsd --tree'
abbr --add t tree --depth=2
abbr --add tt tree --depth=3
abbr --add ttt tree --depth=4
abbr --add tttt tree --depth=5

# git basic
abbr --add ga 'git add'
abbr --add gb 'git branch'
abbr --add gc 'git commit'
abbr --add gco 'git checkout'
abbr --add gd 'git diff'
abbr --add gl 'git pull'
abbr --add gp 'git push'
abbr --add gs 'git status'
abbr --add gst 'git stash'

# git advanced
abbr --add gap 'git add -p'
abbr --add gara 'git commit --amend --reset-author --no-edit'
abbr --add gcm 'git commit -m'
abbr --add gdh 'git diff HEAD'
abbr --add gdm 'git diff master'
abbr --add gi 'git update-index --skip-worktree'
abbr --add glo 'git pull origin HEAD'
abbr --add glu 'git pull upstream HEAD'
abbr --add glup 'glu && git push'
abbr --add gnuke 'git clean -xfd'
abbr --add gnuken 'git clean -xfdn'
abbr --add godel 'git origin --delete'
abbr --add gpsup 'git push -u origin HEAD'
abbr --add grhh 'git reset --hard HEAD'
abbr --add grra 'git rebase -i --exec "git commit --no-edit --amend --author=carl"'
abbr --add gruh 'git reset --hard upstream HEAD'
abbr --add gstp 'git stash pop'
abbr --add gudel 'git upstream --delete'

# emacs
abbr --add ec emacsclient -n
abbr --add suec SUDO_EDITOR="(which emacsclient)" sudo -e
abbr --add ect emacsclient -tty
abbr --add ecw emacsclient --create-frame

# multimedia
abbr --add lain 'say -v whisper "present day, present time."'
abbr --add ffmpeg ffmpeg -loglevel warning -hide_banner
alias mpv='mpv --demuxer-readahead-secs=60'

# weather
abbr --add  w 'curl wttr.in/Shibuya\?format=3'
abbr --add ww 'curl wttr.in/Shibuya\?format=v2'

# k8s, docker
abbr --add k kubectl
abbr --add dockly npx dockly
alias drun='docker run --rm -it'
alias dexec='docker exec -it'

# docker compose
abbr --add dcl docker compose logs
abbr --add dcu docker compose up -d
abbr --add dcd docker compose down
abbr --add dce docker compose exec -it
abbr --add dco docker compose

# development
abbr --add yrc yarn run -T rescript clean
abbr --add yrb yarn run -T rescript build
abbr --add yrbd yarn run -T rescript build -with-deps
abbr --add yrw yarn run -T rescript build -w
