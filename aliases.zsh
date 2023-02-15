# exa aliases
alias ls='exa --icons --group-directories-first --git'
alias l='ls -lbFh'
alias ll='l -a'
alias lt='exa -alh --icons --tree --level=2'
alias lm='ll --sort=mod'

# fzf with fd, bat and exa
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -tf'
export FZF_ALT_C_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -td'
export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
_fzf_compgen_path() {
	command fd -c always -H --no-ignore-vcs -E .git -tf . "${1}"
}
_fzf_compgen_dir() {
	command fd -c always -H --no-ignore-vcs -E .git -td . "${1}"
}
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_ALT_C_OPTS="--ansi --preview 'exa -a --tree --level=2 {}'"
export FZF_CTRL_T_OPTS="--ansi --preview 'command bat --color=always --line-range :500 {}' --select-1 --exit-0"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# get faster download
alias get='aria2c --max-connection-per-server=5 --continue'

# get resource usage
alias df='df -ah'
alias du='du -ah'
alias free='free -m'
alias dskspace="du -S | sort -hr | bat"

# safety operations
alias cpi='cp -i'
alias lni='ln -i'
alias mvi='mv -i'
alias rmi='rm -i'

# ps aliases
alias psa="ps auxf"

# alias to open, copy and paste
alias o='xdg-open'
alias pbc='xclip -selection clipboard -in'
alias pbp='xclip -selection clipboard -out'

# server current directory under http
alias http-serve="jwebserver -b 0.0.0.0"

# less termcolors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;47;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# grepping with colors
alias grep='grep --color=always'
alias egrep='grep -E --color=always'
alias fgrep='grep -F --color=always'

alias -g G='| grep --color=always'
alias -g eG='| grep -E --color=always'
alias -g fG='| grep -F --color=always'

# get last 10 history
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias minitru='nvim $ZDOTDIR/.zhistory'

# configure zoxide
eval "$(zoxide init --cmd j zsh)"

# nvim
alias vim='nvim'

# better edit
e() {
  for file in "$@"
  do 
    [[ ! -e "$file" ]] && install -m 644 -D /dev/null "$file"
  done
  nvim -p "$@"
}

# journalctl error mesages
alias jctl="journalctl -p 3 -xb"

# YTDL setup
YTDL_VIDEO="$HOME/Videos"
YTDL_AUDIO="$HOME/Music"
alias ytda='yt-dlp -f "ba" -x --output-na-placeholder "" --embed-thumbnail --embed-metadata -P $YTDL_AUDIO -o "[%(album)s] %(title)s  %(artist)s (%(upload_date>%Y)s).%(ext)s"'
alias ytdv='yt-dlp -f "bv*+ba/b" --output-na-placeholder "" --sub-langs all --embed-subs --embed-thumbnail --embed-metadata -P $YTDL_VIDEO -o "%(title)s  %(channel)s (%(upload_date>%Y)s).%(ext)s"'

# fd
alias fd='fd -H'

# make directory and change directory
mkcd() {
	[[ -n "$1" ]] && mkdir -p -- "$1" && builtin cd -P -- "$1"
}

# safely remove a file
saferm() {
  [[ ! -n "$1" ]] && { echo "Needs one argument..."; return 1; }
  [[ -d "$1" ]] && { echo "Cannot display a directory, exiting..."; return 1; }
  [[ -f "$1" ]] && bat "$1" && rm -i "$1"
}

# make directories with parent if necessary
mkdp() {
	[[ -n "$1" ]] && mkdir -p -- "$1"
}

# diffs
alias wdiff="command git --no-pager diff --no-ext-diff --no-index --color=auto --color-words"

# suffix extensions
alias -s {mkv,mp4,mov,webm}="vlc"

# arch linux stuff
# note: I don't like sudo in aliases, but still it's there for convenience
alias mirror_latest="sudo reflector -l 20 -p https --sort rate --download-timeout 60 --save /etc/pacman.d/mirrorlist"
alias mirror_fastest="sudo reflector -f 20 -p https --sort age --download-timeout 60 --save /etc/pacman.d/mirrorlist"
alias yay="paru"
alias yayr="paru -R"
alias yays="paru -S --noconfirm --needed"
alias yayup="paru -Syyu --noconfirm"
alias yayQl="paru -Qs"
alias yayQs="paru -Ss"
alias yayQf="paru -F"
alias yayrp='sudo pacman -Rncs $(paru -Qdtq)'
alias yayrc='paru -Sc;sudo paccache -rk1'

# command not found using paru
source $ZDOTDIR/command_not_found.zsh

# clear screen on cls
alias cls=clear

# PDF aliases
alias topdf="libreoffice --headless --convert-to pdf"
mergepdf() {
  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile="$1" "${@:2}"
}

# update zsh plugins
update_zsh_plugins() {
  for dir in "$HOME/.config/zsh/plugins/"*/;
  do 
    echo '\e[1;32mUpdating '$(basename $dir)'\e[0m' && git -C $dir pull
  done
}

# shred shortcuts
alias shredfile="shred -vzu -n7"
alias shredmount="sudo shred -vfz -n7"
