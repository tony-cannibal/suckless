//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
    {" ^c#3a94c5^^d^ ", "/home/luis/.dwm/get-vol.sh"                            ,  0,    10},

    {"^c#3a94c5^^d^ ", "/home/luis/.dwm/get-diskspace.sh"                      , 30,     0},

	{"^c#3a94c5^﬙^d^ ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},

	{"^c#3a94c5^^d^ ", "date '+(%a) %I:%M%p '"                                      ,  5,  	0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
