#!/bin/bash
__WINDEX=$(i3-msg -t get_workspaces \
    | sed 's|.*name\":\"\([a-zA-Z0-9]*\)\",\"visible\":true.*|\1|')

printf '${color1}'
for ((i=1;i<=9;i++)); do
    if [ "$i" == "$__WINDEX" ]; then
        printf ' ${color0}'
        printf "$i"
        printf '${color1}'
    else
        printf " $i"
    fi
done
if [ "$__WINDEX" == 10 ]; then
    printf ' ${color0}0'
else
    printf ' 0'
fi
