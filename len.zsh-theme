function ZSH_setColor() {
    if [ "$1" = "black" ]; then
        echo -n "%{\e[0;30m%}"
    elif [ "$1" = "red" ]; then
        echo -n "%{\e[0;31m%}"
    elif [ "$1" = "green" ]; then
        echo -n "%{\e[0;32m%}"
    elif [ "$1" = "yellow" ]; then
        echo -n "%{\e[0;33m%}"
    elif [ "$1" = "blue" ]; then
        echo -n "%{\e[0;34m%}"
    elif [ "$1" = "purple" ]; then
        echo -n "%{\e[0;35m%}"
    elif [ "$1" = "cyan" ]; then
        echo -n "%{\e[0;36m%}"
    elif [ "$1" = "gray" ]; then
        echo -n "%{\e[0;37m%}"
    elif [ "$1" = "darkGray" ]; then
        echo -n "%{\e[1;30m%}"
    elif [ "$1" = "boldRed" ]; then
        echo -n "%{\e[1;31m%}"
    elif [ "$1" = "boldGreen" ]; then
        echo -n "%{\e[1;32m%}"
    elif [ "$1" = "boldYellow" ]; then
        echo -n "%{\e[1;33m%}"
    elif [ "$1" = "boldBlue" ]; then
        echo -n "%{\e[1;34m%}"
    elif [ "$1" = "boldPurple" ]; then
        echo -n "%{\e[1;35m%}"
    elif [ "$1" = "boldCyan" ]; then
        echo -n "%{\e[1;36m%}"
    elif [ "$1" = "white" ]; then
        echo -n "%{\e[1;37m%}"
    else
        echo -n "%{$reset_color%}"
    fi
}

function ZSH_userColor() {
    if [ $UID = "0" ]; then
        echo -n "$(ZSH_setColor boldRed)"
    else
        echo -n "$(ZSH_setColor boldGreen)"
    fi
}

function ZSH_hostinfo() {
    echo -n "$(ZSH_setColor blue)["
    if [ $SSH_CONNECTION ]; then
        echo -n "$(ZSH_setColor red)(ssh) "
    fi
    ZSH_userColor
    echo -n "%n"
    echo -n "$(ZSH_setColor darkGray)@"
    echo -n "$(ZSH_setColor cyan)%M"
    echo -n "$(ZSH_setColor blue)]"
}

function ZSH_dir() {
    echo -n "$(ZSH_setColor blue)["
    ZSH_dirOwner=$(ls -ld | awk -F ' ' '{ print $3 }')
    if [ "$ZSH_dirOwner" = "$USER" ]; then
        echo -n "$(ZSH_setColor white)"
    elif [ "$ZSH_dirOwner" = "root" ]; then
        echo -n "$(ZSH_setColor boldRed)"
    else
        echo -n "$(ZSH_setColor boldYellow)"
    fi
    echo -n "%~"
    echo -n "$(ZSH_setColor blue)]"
}

function ZSH_datetime() {
    echo -n "$(ZSH_setColor blue)["
    echo -n "$(ZSH_setColor yellow)%D{"%d.%m.%Y %H:%M:%S"}"
    echo -n "$(ZSH_setColor blue)]"
}

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" $(ZSH_setColor green)\u2714"
ZSH_THEME_GIT_PROMPT_DIRTY=" $(ZSH_setColor red)\u2718"

function ZSH_repoinfo() {
    if [ ! -z "$(git_prompt_short_sha)" ]; then
        echo -n "$(ZSH_setColor blue)["
        echo -n "$(ZSH_setColor boldBlue)$(git_prompt_info) $(ZSH_setColor boldBlue)$(git_prompt_short_sha)$(ZSH_setColor)"
        echo -n "$(ZSH_setColor blue)]"
    fi
}

function ZSH_retcode() {
    #echo -n "%(?:$(ZSH_setColor green)\u2714:$(ZSH_setColor red)\u2718) %?\n\r"
    echo -n "%(?::$(ZSH_setColor red)\u2718 %?\n\r)"
}

function ZSH_priv() {
    ZSH_userColor
    if [ "$1" = "0" ]; then
        echo -n "\u250c\u2500"
    else
        echo -n "\u2514\u2500"
    fi
}

function ZSH_input() {
    ZSH_userColor   
    echo -n "%#"
}

RPROMPT=$'$(ZSH_datetime)$(ZSH_setColor)'

PROMPT=$'$(ZSH_retcode)
$(ZSH_priv 0)$(ZSH_hostinfo) $(ZSH_setColor darkGray)- $(ZSH_dir)   $(ZSH_repoinfo)
$(ZSH_priv 1) $(ZSH_input)$(ZSH_setColor) '
