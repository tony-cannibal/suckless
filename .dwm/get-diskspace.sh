#!/usr/bin/sh

df -h /home | tail -n 1 | awk '{print $4}'
