os=`uname -s`

if [[ $os == "Linux" ]]; then
    git_completion="/etc/bash_completion.d/git-prompt"
else
    unset git_completion
fi

if [[ "$git_completion" ]]; then
    if [ -f $git_completion ]; then
           export GIT_PS1_SHOWDIRTYSTATE=true
           export GIT_PS1_SHOWUNTRACKEDFILES=true
           export GIT_PS1_SHOWSTASHSTATE=true
           PS1="$PS1\$(__git_ps1 '(\[\e[31;1m\]%s\[\e[0m\]) ')"
    fi
fi

echo -e '\033[01;37m------ alias git utilisables ------\033[00m'
git config --get-regexp alias

alias lsgit='paste <(ls -ld --color=always *) <(for i in *; do if [ -d "$i"/.git ] ; then echo -e "\033[1;31m($(git --git-dir="$i"/.git symbolic-ref --short HEAD))\033[0m"; else echo; fi; done)'
