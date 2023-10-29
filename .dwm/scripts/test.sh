#!/bin/bash
#
# C=$(curl -Is  http://www.google.com | head -n 1 | awk '{print $3}' | sed -r 's/[[:blank:]]//g')
# C=$(cat < /dev/null > /dev/tcp/www.baeldung.com/53; echo $?)

# C=$(wget -q --spider http://google.com ; echo $?)
# res=$(echo "$C")
# echo "$res"
# other="OK"
# : >/dev/tcp/8.8.8.8/53;
# if [[ "$res" -eq 0 ]];then
if timeout 1 sh -c "true >/dev/tcp/8.8.8.8/53" ;then
    echo 1
else
    echo 0
fi
