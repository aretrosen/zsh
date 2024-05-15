# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZDOTDIR/options.zsh
source $ZDOTDIR/keybinds.zsh

# pyenv configuration
eval "$(pyenv init -)"

fpath=("$ZDOTDIR/.zfunc" "$ASDF_DIR/completions" "$ZDOTDIR/plugins/zsh-completions/src" $fpath)
source $ZDOTDIR/completions.zsh
source $ZDOTDIR/aliases.zsh
source /etc/zsh_command_not_found

source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# pipx configuration
autoload -U bashcompinit && bashcompinit && eval "$(register-python-argcomplete pipx)"

source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme

# opam configuration
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/home/aritro/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/aritro/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# zoxide setup
eval "$(zoxide init zsh)"
