#!/bin/zsh
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

for config_file ($ZSH/lib/*.zsh); do
    source $config_file
done

fpath=($HOME/.zsh.d/completions $fpath)
autoload -U compinit
compinit -i

for plugin ($plugins); do
    if [ -f $ZSH/plugins/$plugin.plugin.zsh ]; then
        source $ZSH/plugins/$plugin.plugin.zsh
    fi
done

if [ -f "$ZSH/themes/$theme.theme.zsh" ]; then
    source "$ZSH/themes/$theme.theme.zsh"
fi
