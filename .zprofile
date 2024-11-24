export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'

export TIMEFMT=$'\n%J\n\nreal\t\033[1;32m%*E\033[0m\nuser\t\e[1;32m%*U\e[0m\nsys\t\e[1;32m%*S\e[0m\ncpu\t\e[1;32m%P\e[0m'

export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export ANDROID_HOME="$HOME/Android/Sdk"
export GOBIN="$HOME/go/bin"
export EMSDK_QUIET=1

export PYTHON_BUILD_HTTP_CLIENT='curl'
export PYTHON_CFLAGS='-march=native -mtune=native -fPIC'
export PYTHON_CONFIGURE_OPTS='--enable-loadable-sqlite-extensions --with-tzpath=/usr/share/zoneinfo --with-dbmliborder=gdbm:bdb:ndbm --disable-gil --enable-experimental-jit=yes-off --with-ensurepip=no --enable-optimizations --with-lto --with-system-expat'
export PROFILE_TASK='-m test.regrtest --pgo -j0'
export ASAN_OPTIONS='stack_trace_format="[frame=%n, function=%f, location=%S]":strict_string_checks=1:detect_stack_use_after_return=1:debug=1:atexit=1:detect_invalid_pointer_pairs=2:check_initialization_order=1:strict_init_order=1:detect_leaks=1'

typeset -U path
path=("$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.elan/bin" "$GOBIN" "$PNPM_HOME" "$ANDROID_HOME/tools" "$ANDROID_HOME/tools/bin" "$ANDROID_HOME/platform-tools" "$XDG_DATA_HOME/mise/shims" "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" "$XDG_DATA_HOME/fzf/bin" "/usr/local/cuda/bin" "/usr/games" $path)
export PATH

source "$XDG_DATA_HOME/emsdk/emsdk_env.sh"
