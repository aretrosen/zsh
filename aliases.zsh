# eza aliases
alias ls='eza --icons --group-directories-first --git'
alias l='ls -lbh'
alias ll='l -a'
alias lr='eza -alh --icons --tree --level=2'
alias lm='ll --sort=mod'

# fzf with fd, bat and eza
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
export FZF_ALT_C_OPTS="--preview 'command eza -a --tree --level=2 {}'"
export FZF_CTRL_T_OPTS="--preview 'command bat --color=always --line-range :500 {}' --select-1 --exit-0"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# get faster download
alias get='aria2c --max-connection-per-server=5 --continue'

# get resource usage
alias df='df -ah'
alias du='du -ah'
alias free='free -m'
alias dskspace="du -S | sort -hr | command bat"

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
  [[ -z $WAYLAND_DISPLAY ]] && command xclip -selection clipboard -in $1 || command wl-copy <$1
}
pbp() {
  [[ -z $WAYLAND_DISPLAY ]] && command xclip -selection clipboard -out $1 || command wl-paste <$1
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
alias grep='command rg --hidden --smart-case'

alias -g G='| grep'
alias -g C='| command wc -l'

# get last 10 history
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias minitru='em $ZDOTDIR/.zhistory'

# vim
alias vim="command nvim"
alias vi="vim"

# emacs
alias em="command emacsclient --alternate-editor= --tty"
emacs() {
	if [[ -n "$*" ]]; then
	  command emacsclient --alternate-editor= --reuse-frame "$@"
	else
	  command emacsclient --alternate-editor= --create-frame
	fi
}

# journalctl error mesages
alias jctl="command journalctl -p 3 -xb"

# YTDL setup
alias ytda='command yt-dlp -f "ba" -x --output-na-placeholder "" --embed-thumbnail --embed-metadata -P ${YTDL_AUDIO:-$HOME/Music} -o "[%(album)s] %(title)s  %(artist)s (%(upload_date>%Y)s).%(ext)s"'
alias ytdv='command yt-dlp -f "(bv*[fps>30]/bv*)[height<=1440]+ba/(b[fps>30]/b)[height<=1440]" --output-na-placeholder "" --sub-langs all --embed-subs --embed-thumbnail --embed-metadata -P ${YTDL_VIDEO:-$HOME/Videos} -o "%(title)s  %(channel)s (%(upload_date>%Y)s).%(ext)s"'

# make directory and change directory
mkcd() {
	[[ -n "$1" ]] && mkdir -p -- "$1" && builtin cd -P -- "$1"
}

# safely remove a file
saferm() {
  [[ ! -n "$1" ]] && { echo "Needs one argument..."; return 1; }
  [[ -d "$1" ]] && { echo "Cannot display a directory, exiting..."; return 1; }
  [[ -f "$1" ]] && batcat "$1" && rm -i "$1"
}

# make directories with parent if necessary
mkdp() {
	[[ -n "$1" ]] && mkdir -p -- "$1"
}

# diffs
alias wdiff="command git --no-pager diff --no-ext-diff --no-index --color=auto --color-words"

# PDF aliases
alias topdf="command libreoffice --headless --convert-to pdf"
mergepdf() {
  command gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile="$1" "${@:2}"
}

alias update-zsh-plugins="git -C $ZDOTDIR submodule update --remote --merge"

# shred shortcuts
alias shredfile="command shred -vzu -n7"
alias shredmount="sudo shred -vfz -n7"

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

# debian shortcuts
alias reboot="systemctl reboot"
alias shutdown="systemctl poweroff"

# aliases for vscode
alias code="code-insiders"

# alias for micromamba
alias conda="micromamba"
