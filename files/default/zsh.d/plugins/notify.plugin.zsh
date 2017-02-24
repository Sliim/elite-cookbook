# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: notify
#
# From https://gist.github.com/hryk/1627790
#
zmodload -i zsh/datetime

elite-notify-send() {
    if [[ -n $TMUX ]]; then
        TMUX_WIN=$(tmux display-message -p "[#S:#I]")
        tmux display-message "$TMUX_WIN $1>> $2"
    fi

    which notify-send 2>&1 > /dev/null
    [ $? -eq 0 ] && notify-send $@ }

typeset -Ag znotify
typeset "znotify[on_success]"='elite-notify-send "$TMUX_WIN $command_name" "$command_name is completed within $elapsed_time sec." -i utilities-terminal -u normal'
typeset "znotify[on_failure]"='elite-notify-send "$TMUX_WIN $command_name" "$command_name failed with exitcode $command_status in $elapsed_time sec." -i utilities-terminal -u critical'
typeset "znotify[ignore]"="vim ssh man less top emacs em eshell builtin tail more su"
typeset "znotify[threshold]"='30'
typeset "znotify[_command]"='0'
typeset "znotify[_command_start]"='0'
typeset "znotify[_disabled]"='0'
typeset "znotify[_strftime_available]"='0'

## Functions
__set_notification(){
    emulate -L zsh
    typeset -a cmd;cmd=(${(z)2})
    znotify[_command_start]=$(date +%s)
    case $cmd[1] in
        fg)
            if (( $#cmd == 1 )); then
                cmd=(builtin jobs -l %+)
            else
                cmd=(builtin jobs -l $cmd[2])
            fi
            ;;
        %*)
            cmd=(builtin jobs -l $cmd[1])
            ;;
        cd)
            if (( $#cmd == 2)); then
                cmd[1]=$cmd[2]
            fi
            ;;
    esac
    for ignore in ${(z)znotify[ignore]}; do
        if [[ ${cmd[1]} == $ignore ]] {
               znotify[_disabled]='1'
               break
           }
    done

    znotify[_command]=$(_real_command)
}

_real_command() {
    for c in {1..$#cmd}; do
        if [ ! $(echo $cmd[$c] | grep "[A-Z]*=") ]; then
            echo $cmd[$c]
            break
        fi
    done
}

__exec_notification(){
    command_status=$?
    if [[ ${znotify[_disabled]} -eq '0' && ${znotify[_command_start]} != '0' ]] {
           integer stopped_time=$(date +%s);
           integer elapsed_time;
           (( elapsed_time = $stopped_time - ${znotify[_command_start]} ))
           if [[ $elapsed_time -ge ${znotify[threshold]} ]] {
                  local command_name;
                  local formatted_elapsed_time;
                  if [[ ${znotify[_strftime_available]} -eq '1' ]] {
                         if [[ $elapsed_time -ge '3600' ]] {
                                formatted_elapsed_time=$(strftime %H:%M:%S $elapsed_time)
                            } elif [[ $elapsed_time -ge '60' ]] {
                                formatted_elapsed_time=$(strftime %M:%S $elapsed_time)
                            } else {
                                formatted_elapsed_time=$elapsed_time
                            }
                     } else {
                         formatted_elapsed_time=$elapsed_time
                     }
                     command_name=${znotify[_command]}

                     if [[ $command_status == 0 ]] {
                            eval ${znotify[on_success]}
                        } else {
                            eval ${znotify[on_failure]}
                        }
              }
       }
       znotify[_command]='0'
       znotify[_command_start]='0'
       znotify[_disabled]='0'
}

__znotify_init(){
    # Check zsh/strftime
    if [[ $(zmodload zsh/strftime 2>/dev/null) -eq '0' ]] {
           znotify[_strftime_available]='1'
       } else {
           znotify[_strftime_available]='0'
       }
       # Setup hooks
       if (($+functions[add-zsh-hook])); then
           add-zsh-hook preexec __set_notification
           add-zsh-hook precmd __exec_notification
       else
           echo '"add-zsh-hook" does not exists. Update zsh to 4.3.4 or later.'
       fi
}

## Main program
__znotify_init
