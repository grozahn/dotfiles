##
## Tomorrow-night, adapted by nicholastmosher
##

evaluate-commands %sh{
    foreground="rgb:c5c8c6"
    background="rgb:1d1f21"
    selection="rgb:373b41"
    window="rgb:383838"
    text="rgb:D8D8D8"
    text_light="rgb:4E4E4E"
    line="rgb:282a2e"
    comment="rgb:969896"
    red="rgb:cc6666"
    orange="rgb:d88860"
    yellow="rgb:f0c674"
    green="rgb:b5bd68"
    green_dark="rgb:a1b56c"
    blue="rgb:81a2be"
    aqua="rgb:87afaf"
    magenta="rgb:ab4642"
    purple="rgb:b294bb"

    primary=${purple}

    ## code
    echo "
        face global value ${yellow}
        face global type ${yellow}
        face global variable ${magenta}
        face global module ${green}
        face global function ${aqua}
        face global string ${green_dark}
        face global keyword ${purple}
        face global operator ${aqua}
        face global attribute ${purple}
        face global comment ${comment}
        face global meta ${purple}
        face global builtin ${blue}
    "

    ## markup
    echo "
        face global title blue
        face global header ${aqua}
        face global bold ${yellow}
        face global italic ${orange}
        face global mono ${green_dark}
        face global block ${orange}
        face global link blue
        face global bullet ${red}
        face global list ${red}
    "

    ## builtin
    echo "
        face global Default ${text},${background}
        face global PrimarySelection default,${selection}
        face global SecondarySelection default,${selection}
        face global PrimaryCursor black,${foreground}
        face global SecondaryCursor black,${foreground}
        face global PrimaryCursorEol black,${text_light}
        face global SecondaryCursorEol black,${text_light}
        face global LineNumbers ${text_light},${background}
        face global LineNumberCursor ${yellow},${background}+b
        face global MenuForeground ${line},${primary}
        face global MenuBackground ${foreground},${line}
        face global MenuInfo ${blue}+b
        face global Information white,${line}
        face global Error white,${red}
        face global StatusLine ${text},${line}
        face global StatusLineMode ${green}+b 
        face global StatusLineInfo ${primary}
        face global StatusLineValue ${green_dark}
        face global StatusCursor ${window},${primary}
        face global Prompt ${background},${primary}
        face global MatchingChar ${yellow},${background}+b
        face global BufferPadding ${text_light},${background}
    "
}
