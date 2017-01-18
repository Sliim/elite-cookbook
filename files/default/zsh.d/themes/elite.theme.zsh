local-version() {
    file=$(upsearch $1)
    [[ -f $file ]] && cat $file || echo -1
}

prompt_zcap_status() {
    if [[ $zcap_running == 1 ]]; then; echo "[%{$FG[$shell_color2]%}zcap%{$reset_color%}%{$FG[$shell_color1]%}]"; fi
}

prompt_py_version() {
    if [ ! -z $pyenv_prompt ]; then
        version=$(local-version .python-version)
        [ $version != -1 ] && echo "[%{$FG[$shell_color2]%}Python-$version%{$reset_color%}%{$FG[$shell_color1]%}]"
    fi
}

prompt_rb_version() {
    if [ ! -z $rbenv_prompt ]; then
        version=$(local-version .ruby-version)
        [ $version != -1 ] && echo "[%{$FG[$shell_color2]%}Ruby-$version%{$reset_color%}%{$FG[$shell_color1]%}]"
    fi
}

prompt_nd_version() {
    if [ ! -z $ndenv_prompt ]; then
        version=$(local-version .node-version)
        [ $version != -1 ] && echo "[%{$FG[$shell_color2]%}Node-$version%{$reset_color%}%{$FG[$shell_color1]%}]"
    fi
}

prompt_yoda_session() {
    [ ! -z $YODA_JUMP_SESSION ] && echo " ϒ"
}

PROMPT=$'%{$FG[$shell_color1]%}┌[%{$FG[$shell_color2]%}%n%{$reset_color%}%{$FG[$shell_color1]%}@%{$FG[$shell_color2]%}%m%{$reset_color%}%{$FG[$shell_color1]%}][%{$FG[$shell_color2]%}/dev/%y%{$reset_color%}%{$FG[$shell_color1]%}]$(prompt_py_version)$(prompt_rb_version)$(prompt_nd_version)$(prompt_zcap_status)%{$(git_prompt_info 2>/dev/null)%}%(?,,%{$FG[$shell_color1]%}[%{$FG[$shell_color2]%}%?%{$reset_color%}%{$FG[$shell_color1]%}])$(prompt_yoda_session)
%{$FG[$shell_color1]%}└[%{$FG[$shell_color2]%}%~%{$reset_color%}%{$FG[$shell_color1]%}]>%{$reset_color%} '
PS2=$' %{$FG[$shell_color1]%}|>%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[$shell_color1]%}[%{$FG[$shell_color2]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$FG[$shell_color1]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}⚡%{$reset_color%}"
