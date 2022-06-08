#!/bin/bash

killall -q polybar
polybar default 2>&1 | tee -a /tmp/polybar.log & disown
