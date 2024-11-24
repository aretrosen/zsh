# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZDOTDIR/options.zsh
source $ZDOTDIR/keybinds.zsh

# command-not-found setup
source /etc/zsh_command_not_found

# zsh-z setup
export ZSHZ_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/zsh-z/data"
source $ZDOTDIR/plugins/zsh-z/zsh-z.plugin.zsh

# set up fzf
source <(fzf --zsh)

# mise configuration
eval "$(mise activate zsh)"

fpath=("$ZDOTDIR/.zfunc" "$ZDOTDIR/plugins/zsh-completions/src" $fpath)
source $ZDOTDIR/completions.zsh
source $ZDOTDIR/aliases.zsh

source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme

# opam configuration
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
