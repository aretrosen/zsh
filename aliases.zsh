# eza aliases
alias ls='eza --icons --group-directories-first --git'
alias l='ls -lbFh'
alias ll='l -a'
alias lr='eza -alh --icons --tree --level=2'
alias lm='ll --sort=mod'

# fzf with fd, bat and eza
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
export FZF_DEFAULT_OPTS="--ansi --height 40% --layout=reverse --border"
export FZF_ALT_C_OPTS="--preview 'eza -a --tree --level=2 {}'"
export FZF_CTRL_T_OPTS="--preview 'command bat --color=always --line-range :500 {}' --select-1 --exit-0"
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

# alias to copy and paste
alias open='xdg-open'
pbc() {
  [[ -z $WAYLAND_DISPLAY ]] && /usr/bin/xclip -selection clipboard -in $1 || /usr/bin/wl-copy <$1
}
pbp() {
  [[ -z $WAYLAND_DISPLAY ]] && /usr/bin/xclip -selection clipboard -out $1 || /usr/bin/wl-paste <$1
}

# server current directory under http
alias http-server="jwebserver -b 0.0.0.0"

# less termcolors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;47;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# grepping with colors
alias grep='/usr/bin/rg --hidden --smart-case'

alias -g G='| grep'
alias -g C='| /usr/bin/wc -l'

# get last 10 history
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias minitru='nvim $ZDOTDIR/.zhistory'

# nvim
alias vim='nvim'
alias vi='vim'

# emacs
alias emacs="/usr/bin/emacsclient -c -a 'emacs'"

# journalctl error mesages
alias jctl="/usr/bin/journalctl -p 3 -xb"

# YTDL setup
alias ytda='/usr/bin/yt-dlp -f "ba" -x --output-na-placeholder "" --embed-thumbnail --embed-metadata -P ${YTDL_AUDIO:-$HOME/Music} -o "[%(album)s] %(title)s  %(artist)s (%(upload_date>%Y)s).%(ext)s"'
alias ytdv='/usr/bin/yt-dlp -f "(bv*[fps>30]/bv*)[height<=1440]+ba/(b[fps>30]/b)[height<=1440]" --output-na-placeholder "" --sub-langs all --embed-subs --embed-thumbnail --embed-metadata -P ${YTDL_VIDEO:-$HOME/Videos} -o "%(title)s  %(channel)s (%(upload_date>%Y)s).%(ext)s"'

# fd
alias fd='/usr/bin/fd -H'

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
alias mirror-latest="sudo reflector --age 6 --latest 20 --protocol https --sort rate --download-timeout 60 --save /etc/pacman.d/mirrorlist && sudo pacman -Syy"
alias mirror-fastest="sudo reflector --age 6 --fastest 20 --protocol https --sort age --download-timeout 60 --save /etc/pacman.d/mirrorlist && sudo pacman -Syy"
alias yas="/usr/bin/yay --noconfirm -S --needed"
alias yup="/usr/bin/yay --noconfirm --answeredit NotInstalled -Syu"
alias yar="/usr/bin/yay -R"
alias yayQl="/usr/bin/yay -Qs"
alias yayQs="/usr/bin/yay -Ss"
alias yayQf="/usr/bin/yay -F"
alias yayRp='sudo pacman -Rncs $(/usr/bin/yay -Qdtq)'
alias yayCc='/usr/bin/yay -Sc && sudo paccache -rk1'

# PDF aliases
alias topdf="/usr/bin/libreoffice --headless --convert-to pdf"
mergepdf() {
  /usr/bin/gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile="$1" "${@:2}"
}

alias update-zsh-plugins="git -C $ZDOTDIR submodule update --remote --merge"

# shred shortcuts
alias shredfile="/usr/bin/shred -vzu -n7"
alias shredmount="sudo /usr/bin/shred -vfz -n7"

# clear and reset
clear() {
  echoti civis >"$TTY"
  printf '%b' '\e[H\e[2J' >"$TTY"
  TRAPWINCH() {
    zle && { zle .reset-prompt; zle -R }
  }
  printf '%b' '\e[3J' >"$TTY"
  echoti cnorm >"$TTY"
}
alias cls="clear"

# make arrow keys work
alias clasp="rlwrap clasp"

# aliases for jetbrains toolbox for android studio
alias jetbrains-toolbox="nohup /opt/jetbrains-toolbox/jetbrains-toolbox &>/dev/null & disown"

# aliases for vscode
alias code="code-insiders"

# alias for chromium
alias chromium="nohup chromium --user-data-dir=$HOME/chromium-custom-profiles/WithPlugins &>/dev/null & disown"
alias chromium-apps="nohup chromium --user-data-dir=$HOME/chromium-custom-profiles/OnlineProfile &>/dev/null & disown"
