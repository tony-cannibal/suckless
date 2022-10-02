#!/usr/bin/sh

amixer sget Master | tail -n 1 | awk '{print $4}' | tr -d "[]"
