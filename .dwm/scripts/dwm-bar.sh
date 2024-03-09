
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
        date +"T%l:%M%P "
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
    # while :; do
    #     printf 'H%s\n' "$(df -h /home | tail -n 1 | awk '{print $4}')"
    #     sleep 4
    # done

    while :; do
        R=$(df -h /home | tail -n 1 | awk '{print $4}')
        M=$(df -h /home/luis/.media | tail -n 1 | awk '{print $4}')
        echo "HR:$R M:$M"
        sleep 4
    done
}

volume()
{
        printf 'V%s\n' "$(pamixer --get-volume-human)"
}

internet()
{

    while :; do
        # C=$(wget -q --spider http://google.com ; echo $?)
        # echo "C$C"

        if timeout 1 sh -c "true >/dev/tcp/8.8.8.8/53" ;then
            echo "C1"
        else
            echo "C0"
        fi
        sleep 2
    done
}

parsefifo()
{
	typeset time='' vol=''  s="$separator" memory='' disk='' con=''

	while read -r line; do
		case $line in
			T*)
                time=$( echo "${line#?}" | sed -r "s/^[[:blank:]]+|[[:blank:]]+$//g")
                time="^c#377375^ ^d^${time}"
                ;;
            R*)
                memory="^c#377375^󰍛 ^d^${line#?}"
                ;;
			V*)

                vol=$( echo "${line#?}" | sed -r "s/^[[:blank:]]+|[[:blank:]]+$//g")
                vol="^c#377375^ ^d^${vol}"
                ;;
            H*)
                disk="^c#377375^󰋊 ^d^${line#?}"
                ;;
            C*)
                res=$( echo "${line#?}" | sed -r "s/[[:blank:]]//g")
                if [ $res -eq 1 ]; then
                    con=" ^c#377375^󰈀 ^d^Up"
                    # con="^c#377375^󰈁 ^d^${line#?}"
                else
                    con=" ^c#cc241d^󰈂 ^d^"
                fi 
                ;;
		esac
		xsetroot -name " [${disk}][${memory}][${vol}][${con}][${time}] "
	done
}


clock > "$fifo" &
memory > "$fifo" &
disk > "$fifo" &
volume > "$fifo" &
internet > "$fifo" &

parsefifo < "$fifo"

