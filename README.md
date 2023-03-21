# zsh
My zsh dotfiles.

## Performance:
The startup of zsh is tuned to be extremely fast. As it is my primary shell, and I have an habit of rapidly closing and opening
different terminals, fast startup time was preferred for me. See the results of the tuning below, and decide for yourself.
```bash
❯ hyperfine --warmup 10 --runs 20 'zsh'
Benchmark 1: zsh
  Time (mean ± σ):       1.3 ms ±   0.0 ms    [User: 1.2 ms, System: 0.9 ms]
  Range (min … max):     1.2 ms …   1.3 ms    20 runs
```
