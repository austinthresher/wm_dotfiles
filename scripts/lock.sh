#!/bin/sh

finish() {
    rm -f /tmp/screen_locked.png
}
trap finish EXIT

ffmpeg -f x11grab \
    -video_size 3840x2160 \
    -y -i $DISPLAY \
    -i $HOME/.wm_dotfiles/files/lock.png \
    -filter_complex "boxblur=5,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" \
    -vframes 1 \
    /tmp/screen_locked.png

i3lock --image=/tmp/screen_locked.png --ignore-empty-password
