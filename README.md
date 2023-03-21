# zsh
My zsh dotfiles.

## Performance:
The startup of zsh is tuned to be extremely fast. As it is my primary shell, and I have an habit of rapidly closing and opening
different terminals, fast startup time was preferred for me. See the results of the tuning below, and decide for yourself.
```bash
❯ hyperfine zsh
Benchmark 1: zsh
  Time (mean ± σ):       1.4 ms ±   0.2 ms    [User: 1.3 ms, System: 0.8 ms]
  Range (min … max):     1.2 ms …   4.1 ms    893 runs
```
