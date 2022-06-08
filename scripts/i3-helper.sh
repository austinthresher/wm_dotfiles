#!/bin/bash
set -x
# Launches compton and conky with resolution-dependant settings
if ps -aux | grep compton | grep -vq grep; then
    killall -q compton -9
fi
if ps -aux | grep conky | grep -vq grep; then
    killall -q conky -9
fi

__RESOLUTION=$(xrandr | head -n 1 | sed 's/.*current \([0-9]*\) x \([0-9]*\).*$/\1x\2/')
if [ -z "$__RESOLUTION" ]; then
    i3-msg bar hidden_state show
else
    i3-msg bar hidden_state hide
    compton --daemon
    __HEIGHT=${__RESOLUTION##*x}
    __WIDTH=${__RESOLUTION%%x*}
    echo "$__RESOLUTION"
    if [ -d "/sys/class/power_supply/BAT0" ]; then
        cat "$HOME/.conkyrc" \
            | sed \
                -e "s@%WIDTH%@$__WIDTH@g" \
                -e "s@%HEIGHT%@$__HEIGHT@g" \
                -e '33i${template1}    \\' \
            > "$HOME/.conky.gen"
    else
        cat "$HOME/.conkyrc" \
            | sed \
                -e "s@%WIDTH%@$__WIDTH@g" \
                -e "s@%HEIGHT%@$__HEIGHT@g" \
            > "$HOME/.conky.gen"
    fi

    if [ "$__HEIGHT" -gt 1080 -a "$__WIDTH" -gt 1920 ]; then
        conky -y 32 --config="$HOME/.conky.gen" --daemonize
        i3-msg gaps inner all set 128 &> /dev/null
    elif [ "$__HEIGHT" -gt 1366 -a "$__WIDTH" -gt 768 ]; then
        conky -y 24 --config="$HOME/.conky.gen" --daemonize
        i3-msg gaps inner all set 64 &> /dev/null
    else
        conky -y 16 --config="$HOME/.conky.gen" --daemonize
        i3-msg gaps inner all set 8 
        i3-msg gaps bottom all set 8 
    fi
fi
