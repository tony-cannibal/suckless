
fifo="/tmp/dwm-bar.fifo"


# kill the process and cleanup if we exit or get killed
trap "trap - TERM; kill 0; rm -f '$fifo'" INT TERM QUIT EXIT

# make the fifo
[ -e "$fifo" ] && rm "$fifo"
mkfifo "$fifo"

separator="|"

clock()
{
    while :; do
        date +"T%l:%M %P "
        sleep 10
    done
}

memory() 
{
    while :; do
        printf 'R%s\n' "$(free -h | sed -n '2p' | awk '{print $3"/"$2}' | sed 's/i//g')"
        sleep 2
    done
}

disk()
{
    while :; do
        printf 'H%s\n' "$(df -h /home | tail -n 1 | awk '{print $4}')"
        sleep 4
    done
}

volume()
{
        printf 'V%s\n' "$(pamixer --get-volume-human)"
}

parsefifo()
{
	typeset time='' vol=''  s="$separator" memory='' disk=''

	while read -r line; do
		case $line in
			T*)
                time="^c#377375^ ^d^${line#?}"
                ;;
            R*)
                memory="^c#377375^󰍛 ^d^${line#?}"
                ;;
			V*)
                vol="^c#377375^ ^d^${line#?}"
                ;;
            H*)
                disk="^c#377375^󰋊 ^d^${line#?}"
                ;;
		esac
		xsetroot -name "[${disk}][${memory}][${vol}][${time}]"
	done
}


clock > "$fifo" &
memory > "$fifo" &
disk > "$fifo" &
volume > "$fifo" &

parsefifo < "$fifo"

