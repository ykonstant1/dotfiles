#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=
HISTFILESIZE=
HISTFILE=~/.eternal_history

PROMPT_COMMAND='history -a;
printf "\033[5 q"'

. ~/.shrc
. ~/.sh.d/prompts.sh
. /usr/share/fzf/key-bindings.bash
. /usr/share/fzf/completion.bash
