# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi


ttpath=/localdata/zhennanc
export qinghua=" -i https://pypi.tuna.tsinghua.edu.cn/simple"


# Aliases
alias l='ls -l'
alias a='cd .. && l'
alias cc='rz -bye'
alias q='vi hlod'
alias shf='sh build.sh'
alias shc='source ~/.bashrc'
alias lt='ls -lhrt --color=auto'
alias via='vi ~/.bashrc'
alias py='python'
alias b='cd -'
alias tt='cd $ttpath'
alias tts='cd /data/home/qijunhuang/czn/code/eggroll-2.x/python/eggroll/roll_site/test'
alias cl='conda info --envs'




# Functions
ff() {
    find ./ -name "$1"
}

dm() {
    docker stop "$1"
    docker rm "$1"
}

ca() {
    conda activate "$1"
}

cr() {
    conda remove -n "$1" --all
}

de() {
    docker exec -it "$1" /bin/bash
}

dp() {
    docker ps -a
}

gs() {
    git status
}

gl() {
    git log --oneline
}

gc() {
    git checkout "$1"
}

tb() {
    tensorboard --port 12400 --bind_all --logdir="$1"
}

nvpython() {
    nsys nvprof --track-memory-allocations=true --trace=osrt,cuda,nvtx python "$1"
}

gdbpython() {
    cuda-gdb --args python3 "$1"
}

to1000() {
    chown 1000:1000 "$1" -R
    chmod 775 "$1" -R
}

p() {
    ps aux | grep "$1"
}


net() {
    netstat -nlp | grep "$1"
}





dd() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.xz)  xz -d "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.rar)     unrar e "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjvf "$1" ;;
            *.tgz)     tar xzvf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *)         echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export XDG_CURRENT_DESKTOP=test
export DETECTRON2_DATASETS=/localdata/zhennanc/data
export PATH=/usr/local/NVIDIA-Nsight-Compute:$PATH
export PATH=/usr/local/cuda/bin:$PATH


py=/opt/conda/envs/nv310/lib/python3.10/site-packages
version=${py}/torch

export LIBTORCH_PATH=${version}
export LD_LIBRARY_PATH=${version}/lib:$LD_LIBRARY_PATH
export CMAKE_PREFIX_PATH=${version}/share/cmake/Torch:$CMAKE_PREFIX_PATH


export LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export PYBIND_PATH=${py}/pybind11/share/cmake/pybind11

git config --global user.email "chanzhennan@163.com"
git config --global user.name "chanzhennan"


# export http_proxy=http://127.0.0.1:8118
# export https_proxy=http://127.0.0.1:8118


#export http_proxy=http://14.29.180.89:7500
#export https_proxy=http://14.29.180.89:7500


