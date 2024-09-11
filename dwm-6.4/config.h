/* See LICENSE file for copyright and license details. */

/* appearance */
static unsigned int borderpx = 2;    /* border pixel of windows */
static const unsigned int gappx = 8; /* gaps between windows */
static unsigned int snap = 32;       /* snap pixel */
static const unsigned int systraypinning =
    0; /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor
          X */
static const unsigned int systrayonleft =
    0; /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int systraypinningfailfirst =
    1; /* 1: if pinning fails, display systray on the first monitor, False:
          display systray on the last monitor*/
static const int showsystray = 1; /* 0 means no systray */
static int showbar = 1;           /* -1 means no bar */
static int topbar = 1;            /* 0 means bottom bar */
static const int focusonwheel = 0;
static char font[] = "terminus:size=12";
static char dmenufont[] = "terminus:size=14";
static const char *fonts[] = {"terminus:size=12",
                              "TerminessTTF Nerd Font:size=9"};
static char normbgcolor[] = "#1e1e1e";
static char normbordercolor[] = "#444444";
static char normfgcolor[] = "#e6d4a3";
static char selfgcolor[] = "#e6d4a3";
static char selbordercolor[] = "#377375";
static char selbgcolor[] = "#377375";
static char *colors[][3] = {
    /*               fg           bg           border   */
    [SchemeNorm] = {normfgcolor, normbgcolor, normbordercolor},
    [SchemeSel] = {selfgcolor, selbgcolor, selbordercolor},
};

typedef struct {
  const char *name;
  const void *cmd;
} Sp;
const char *spcmd1[] = {"st", "-n", "spterm", "-g", "150x50", NULL};
const char *spcmd2[] = {"st",     "-n", "spfm",   "-g",
                        "200x80", "-e", "ranger", NULL};
const char *spcmd3[] = {"keepassxc", NULL};
const char *spcmd4[] = {"st",     "-n", "spmpd",   "-g",
                        "220x80", "-e", "ncmpcpp", NULL};
static Sp scratchpads[] = {
    /* name          cmd  */
    {"spterm", spcmd1},
    {"spranger", spcmd2},
    {"keepassxc", spcmd3},
    {"spmpd", spcmd4},
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class             instance    title       tags mask     isfloating
       monitor */
    {"Gimp", NULL, NULL, 0, 1, -1},
    {"firefox", NULL, NULL, 1 << 1, 0, -1},
    {"Pcmanfm", NULL, NULL, 1 << 2, 0, -1},
    {"Nemo", NULL, NULL, 1 << 2, 0, -1},
    {"Deluge", NULL, NULL, 1 << 3, 0, -1},
    {"Brave-browser", NULL, NULL, 1 << 1, 0, -1},
    {NULL, "spterm", NULL, SPTAG(0), 1, -1},
    {NULL, "spfm", NULL, SPTAG(1), 1, -1},
    {NULL, "keepassxc", NULL, SPTAG(2), 0, -1},
    {NULL, "spmpd", NULL, SPTAG(3), 1, -1},
};

/* layout(s) */
static float mfact = 0.55;  /* factor of master area size [0.05..0.95] */
static int nmaster = 1;     /* number of clients in master area */
static int resizehints = 0; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"><>", NULL}, /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static const char *dmenucmd[] = {
    "dmenu_run", "-l",  "14",           "-x",  "830",       "-y",
    "200",       "-z",  "260",          "-p",  "Apps:",     "-bw",
    "3",         "-fn", dmenufont,      "-nb", normbgcolor, "-nf",
    normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor,  NULL};

static const char *termcmd[] = {"st", NULL};
static const char *powercmd[] = {"/home/luis/.dwm/scripts/dmenu-power.sh",
                                 NULL};
static const char *volupcmd[] = {"/home/luis/.dwm/scripts/vol-up.sh", NULL};
static const char *voldowncmd[] = {"/home/luis/.dwm/scripts/vol-down.sh", NULL};
static const char *voltogglecmd[] = {"/home/luis/.dwm/scripts/vol-toggle.sh",
                                     NULL};

#include "shift-tools.c"

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
    {"font", STRING, &font},
    {"dmenufont", STRING, &dmenufont},
    {"normbgcolor", STRING, &normbgcolor},
    {"normbordercolor", STRING, &normbordercolor},
    {"normfgcolor", STRING, &normfgcolor},
    {"selbgcolor", STRING, &selbgcolor},
    {"selbordercolor", STRING, &selbordercolor},
    {"selfgcolor", STRING, &selfgcolor},
    {"borderpx", INTEGER, &borderpx},
    {"snap", INTEGER, &snap},
    {"showbar", INTEGER, &showbar},
    {"topbar", INTEGER, &topbar},
    {"nmaster", INTEGER, &nmaster},
    {"resizehints", INTEGER, &resizehints},
    {"mfact", FLOAT, &mfact},
};

static const Key keys[] = {
    /* modifier                     key             function        argument */
    {MODKEY, XK_p, spawn, {.v = dmenucmd}},
    {MODKEY | ShiftMask, XK_Return, spawn, {.v = termcmd}},
    {MODKEY, XK_x, spawn, {.v = powercmd}},
    {MODKEY, XK_KP_Add, spawn, {.v = volupcmd}},
    {MODKEY, XK_KP_Subtract, spawn, {.v = voldowncmd}},
    {MODKEY, XK_s, spawn, {.v = voltogglecmd}},
    {MODKEY, XK_period, shiftview, {.i = +1}},
    {MODKEY, XK_comma, shiftview, {.i = -1}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_Return, zoom, {0}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY | ShiftMask, XK_c, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_f, setlayout, {.v = &layouts[1]}},
    {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
    {MODKEY, XK_space, setlayout, {0}},
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    /*	{ MODKEY,                       XK_comma,       focusmon,       {.i = -1
       } }, { MODKEY,                       XK_period,      focusmon,       {.i
       = +1 } }, */
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    {MODKEY, XK_minus, setgaps, {.i = -1}},
    {MODKEY, XK_equal, setgaps, {.i = +1}},
    {MODKEY | ShiftMask, XK_equal, setgaps, {.i = 0}},
    {MODKEY, XK_y, togglescratch, {.ui = 0}},
    {MODKEY, XK_u, togglescratch, {.ui = 1}},
    {MODKEY, XK_a, togglescratch, {.ui = 3}},
    /*	{ MODKEY,                       XK_x,      togglescratch,  {.ui = 2 } },
     */
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8){MODKEY | ShiftMask, XK_q, quit, {0}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function argument */
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button1, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
