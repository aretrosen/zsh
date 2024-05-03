# set up vim mode for zsh

# sourcinf fzf keybinding first, as I am gonna overwrite some
source /usr/share/doc/fzf/examples/key-bindings.zsh

KEYTIMEOUT=15
bindkey -v

# binding key sequences to some main key sequences
# Credit: https://github.com/romkatv/zsh4humans/tree/v5
bindkey -s '^[OA'    '^[[A'
bindkey -s '^[OB'    '^[[B'
bindkey -s '^[OC'    '^[[C'
bindkey -s '^[OD'    '^[[D'
bindkey -s '^[OF'    '^[[F'
bindkey -s '^[OH'    '^[[H'
bindkey -s '^[OM'    '^M'
bindkey -s '^[OX'    '='
bindkey -s '^[Oc'    '^[[1;5C'
bindkey -s '^[Od'    '^[[1;5D'
bindkey -s '^[Oj'    '*'
bindkey -s '^[Ok'    '+'
bindkey -s '^[Om'    '-'
bindkey -s '^[Oo'    '/'
bindkey -s '^[[1;9C' '^[[1;3C'
bindkey -s '^[[1;9D' '^[[1;3D'
bindkey -s '^[[1~'   '^[[H'
bindkey -s '^[[3\^'  '^[[3;5~'
bindkey -s '^[[4~'   '^[[F'
bindkey -s '^[[7~'   '^[[H'
bindkey -s '^[[8~'   '^[[F'
bindkey -s '^[^[[3~' '^[[3;3~'
bindkey -s '^[^[[C'  '^[[1;3C'
bindkey -s '^[^[[D'  '^[[1;3D'

# set keybindings for vicmd mode
# setting Ctrl-Left, Ctrl-Right, Alt-Left, Alt-Right just as in neovim
bindkey -M vicmd '^[[1;3C' forward-char
bindkey -M vicmd '^[[1;3D' backward-char
bindkey -M vicmd '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5D' backward-word

# delete key in neovim deletes a character
bindkey -M vicmd '^[[3~' delete-char

# setting PgUp and PgDown in vicmd as well
bindkey -M vicmd '^[[5~' up-line-or-history
bindkey -M vicmd '^[[6~' down-line-or-history

# setting Home and End keys in Normal/vicmd mode as in neovim
bindkey -M vicmd '^[[F' end-of-line
bindkey -M vicmd '^[[H' beginning-of-line

# incremental history search
bindkey -M vicmd "/" history-incremental-pattern-search-forward
bindkey -M vicmd "?" history-incremental-pattern-search-backward

# in vicmd mode, Ctrl-R redo last change instead of using fzf
bindkey -M vicmd '^R' redo

# Backspace only works in Insert mode in neovim
bindkey '^?' backward-delete-char

# setting Ctrl-Left, Ctrl-Right, Alt-Left, Alt-Right just as in neovim
bindkey '^[[1;3C' forward-char
bindkey '^[[1;3D' backward-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# setting Del key
bindkey '^[[3~' delete-char

# setting PgUp/PgDown keys
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history

# setting Home and End keys
bindkey '^[[F' end-of-line
bindkey '^[[H' beginning-of-line

# unalias any run-help
(( ${+aliases[run-help]} )) && unalias run-help

# load module for help mode
autoload -Uz run-help

# run help for commands in vicmd mode
bindkey -M vicmd 'H' run-help

# specialized run-help-cmds. See man zshcontrib
local cmd
for cmd in btrfs git ip openssl sudo; do
  if (( ${+commands[${cmd}]} )) autoload -Uz run-help-${cmd}
done
unset cmd

# Insert key
bindkey '^[[2~' overwrite-mode

# expand space
bindkey ' ' magic-space

# expand aliases
glob-alias() {
  zle _expand_alias
  zle expand-word
  zle magic-space
}
zle -N glob-alias
bindkey '^ ' glob-alias

# insert last word in viins mode
bindkey "^[." insert-last-word

# go to previous menu item
bindkey '^[[Z' reverse-menu-complete

# Ctrl-x Ctrl-e to edit command-line in EDITOR
autoload -Uz edit-command-line && zle -N edit-command-line && \
	bindkey "^X^E" edit-command-line && bindkey -M vicmd "^X^E" edit-command-line

# smart URL pasting and escaping.
autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic

# prepend sudo on double escape
prepend-sudo() {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend-sudo
bindkey -M vicmd "^[^[" prepend-sudo
bindkey "^[^[" prepend-sudo

# dot expansion
double-dot-expand() {
  if [[ ${LBUFFER} == (|*[[:space:]!\"\&\'/\;\<\>|]).. ]]; then
	  LBUFFER+=/..
  else
	  LBUFFER+=.
  fi
}
zle -N double-dot-expand
bindkey . double-dot-expand
bindkey -M isearch . self-insert

# https://unix.stackexchange.com/a/614203
# change cursor shape for different vi modes.
zle-keymap-select() {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
}
zle -N zle-line-init

# https://unix.stackexchange.com/a/390523
# copy and paste in vi-mode from clipboard
x11-clip-wrap-widgets() {
    local copy_or_paste=$1
    shift

    for widget in $@; do
        if [[ $copy_or_paste == "copy" ]]; then
            eval "
            _x11-clip-wrapped-$widget() {
                zle .$widget
                xclip -sel c -i <<<\$CUTBUFFER
            }
            "
        else
            eval "
            _x11-clip-wrapped-$widget() {
                CUTBUFFER=\$(xclip -sel c -o)
                zle .$widget
            }
            "
        fi
        zle -N $widget _x11-clip-wrapped-$widget
    done
}

local copy_widgets=(
    vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
    vi-put-{before,after}
)

x11-clip-wrap-widgets copy $copy_widgets
x11-clip-wrap-widgets paste  $paste_widgets

unset copy_widgets
unset paste_widgets

# exit any time
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh
