#!/bin/sh

return='↵'
export OLDPS1="$PS1"

B='\033[1m'
R='\033[0m'
r='\033[31m'
g='\033[32m'
b='\033[34m'

rgb()  { printf "\033[38;2;${1};${2};${3}m"; }
rgbb() { printf "\033[48;2;${1};${2};${3}m"; }

colf() { printf "\033[38;5;${1}m"; }
colb() { printf "\033[48;5;${1}m"; }

Y="$(colf 3)"
M="$(colf 5)"

git_prompt() {
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    branch_name=$(git symbolic-ref -q HEAD)
    branch_name=${branch_name##refs/heads/}
    branch_name=${branch_name:-HEAD}

    printf '%s' " ➛ "

    if [[ $(git status 2> /dev/null | tail -n1) = *"nothing to commit"* ]]; then
      printf "${B}${b}%s${R}" "$branch_name"
    elif [[ $(git status 2> /dev/null | head -n5) = *"Changes to be committed"* ]]; then
      printf "${B}${b}%s${r}?${R}" "${branch_name}"
    else
      printf "${B}${b}%s${r}*${R}" "${branch_name}"
    fi
  fi
}

export PS1="${B}${b}┌─[${R}${B}\s:${R}\!${B}${b}] ─ [${g}\u${R}${B}@${R}${r}\H${R}:${TTY#*/*/}${B}${b}] ─ [${R}${B}\w${R}"'$(git_prompt)'"${B}${b}] ─ [${R}${Y}\d, \t${B}${b}] ─ [${R}"'$?'"${B}${b}]\n└─[${M}⌾${b}]${R} "
