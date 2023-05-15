export EDITOR="/usr/local/bin/nvim"
export VISUAL="/usr/local/bin/nvim"
export MANPAGER="nvim +Man!"

export TIMEFMT=$'\n%J\n\nreal\t\033[1;32m%*E\033[0m\nuser\t\e[1;32m%*U\e[0m\nsys\t\e[1;32m%*S\e[0m\ncpu\t\e[1;32m%P\e[0m'

export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export DENO_INSTALL="$HOME/.deno"
export PYENV_ROOT="$HOME/.pyenv"
export GOPATH="$HOME/go"

export ASAN_OPTIONS='stack_trace_format="[frame=%n, function=%f, location=%S]":strict_string_checks=1:detect_stack_use_after_return=1:debug=1:atexit=1:verbosity=1:detect_invalid_pointer_pairs=2:check_initialization_order=1:strict_init_order=1:detect_leaks=1'

source "$HOME/.cargo/env"

typeset -U path
path=("$HOME/.local/bin" "/usr/local/go/bin" "/usr/local/zig" "/opt/cuda/bin" "$HOME/.plenv/bin" "$PYENV_ROOT/bin" "$PNPM_HOME" "$GOPATH/bin" "$DENO_INSTALL/bin" $path)
export PATH

eval "$(pyenv init --path)"
eval "$(pdm --pep582)"
