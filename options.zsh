# cd if what is typed isn't a command
setopt autocd

# push old directory to the directory stack when doing cd
setopt autopushd

# don't push a directory to the stack when it's already there
setopt pushdignoredups

# silent pushd/popd
setopt pushdsilent

# do `pushd ${HOME}` when used without arguments
setopt pushdtohome

# move cursor to end on completion
setopt alwaystoend

# list choices on ambiguous completion
setopt autolist

# automatically add / to directories
setopt autoparamslash

# completion from both side
setopt completeinword

# don't beep on ambiguous list completions
setopt nolistbeep

# extended symbol globbing
setopt extendedglob

# show dotfiles as well
setopt globdots

# sort files numerically when possible
setopt numericglobsort

# expand array parameters
setopt rcexpandparam

# no case globbing
setopt nocaseglob

# set file to save history
HISTFILE=${ZDOTDIR}/.zhistory

# lines of history stored in a session
HISTSIZE=50000

# lines of history store in the HISTFILE
SAVEHIST=40000

# append histories instead of replacing them
setopt appendhistory

# remove oldest history which has duplicate before removing a unique one
setopt histexpiredupsfirst

# don't display previously found history while searching
setopt histfindnodups

# don't enter duplicates of the previous command
setopt histignoredups

# remove commands from the history that starts with a space
setopt histignorespace

# don't store history commands
setopt histnostore

# remove extra blanks from each command line
setopt histreduceblanks

# don't execute the command directly upon history expansion
setopt histverify

# share the same history 'session' among all terminals
setopt sharehistory

# don't allow redirection to existing files
setopt noclobber

# allow comments in interactive shells too
setopt interactivecomments

# print verbose job notifications
setopt longlistjobs

# prevent background jobs being given a lower priority
setopt nobgnice

# prevent status report of jobs on shell exit
setopt nocheckjobs

# don't set SIGHUPs on running jobs while exiting shell
setopt nohup

# don't beep on errors
setopt nobeep
