export EDITOR="/usr/local/bin/nvim"
export VISUAL="/usr/local/bin/nvim"
export MANPAGER="nvim +Man!"

export TIMEFMT=$'\n%J\n\nreal\t\033[1;32m%*E\033[0m\nuser\t\e[1;32m%*U\e[0m\nsys\t\e[1;32m%*S\e[0m\ncpu\t\e[1;32m%P\e[0m'

export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export PYENV_ROOT="$HOME/.pyenv"
export GOPATH="$HOME/go"
export ANDROID_HOME="$HOME/Android/Sdk"
export BUN_INSTALL="$HOME/.bun"

export ASAN_OPTIONS='stack_trace_format="[frame=%n, function=%f, location=%S]":strict_string_checks=1:detect_stack_use_after_return=1:debug=1:atexit=1:detect_invalid_pointer_pairs=2:check_initialization_order=1:strict_init_order=1:detect_leaks=1'

# cargo setup
source "$HOME/.cargo/env"

# intel compiler setup
source "/opt/intel/oneapi/setvars.sh" &>/dev/null

# path setup
typeset -U path
path=("$HOME/.local/bin" "$HOME/.plenv/bin" "$PYENV_ROOT/bin" "$PNPM_HOME" "$GOPATH/bin" "$ANDROID_HOME/tools" "$ANDROID_HOME/tools/bin" "$ANDROID_HOME/platform-tools" "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" "$BUN_INSTALL/bin" $path)
path+="/opt/cuda/bin"
export PATH

# pyenv stuff
eval "$(pyenv virtualenv-init -)"
