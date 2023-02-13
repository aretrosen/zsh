export EDITOR="/usr/local/bin/nvim"
export VISUAL="/usr/local/bin/nvim"
export MANPAGER="nvim +Man!"

TIMEFMT=$'\n%J\n\nreal\t\033[1;32m%*E\033[0m\nuser\t\e[1;32m%*U\e[0m\nsys\t\e[1;32m%*S\e[0m\ncpu\t\e[1;32m%P\e[0m'

export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export DENO_INSTALL="$HOME/.deno"
export PYENV_ROOT="$HOME/.pyenv"
export GOPATH="$HOME/go"

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

source "$HOME/.cargo/env"

source "$HOME/emsdk/emsdk_env.sh"

typeset -U path
path=("$HOME/.local/bin" "/usr/local/go/bin" "$HOME/.plenv/bin" "$PYENV_ROOT/bin" "$PNPM_HOME" "$DENO_INSTALL/bin" $path)
export PATH

eval "$(pyenv init --path)"
eval "$(pdm --pep582)"
eval "$(ssh-agent -s)"
