[ -f ~/.bashrc ] && . ~/.bashrc

export PATH="$PATH:$HOME/.local/bin:$HOME/.bin:$HOME/.cargo/bin"
export GOPATH="$HOME/.go"

# Qt look and feel
[ $XDG_CURRENT_DESKTOP != 'KDE' ] && [ $XDG_CURRENT_DESKTOP != 'LXQt' ] && {
    export QT_QPA_PLATFORMTHEME='qt5ct'
}

# Use GTK3 theme for Java applications
export _JAVA_OPTIONS=(-Dawt.useSystemAAFontSettings=on
                     -Dswing.aatext=true
                     -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel
                     -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel
                     -Dsun.java2d.opengl=true
                     -Djdk.gtk.version=3)

_SILENT_JAVA_OPTIONS="${_JAVA_OPTIONS[@]}"
unset _JAVA_OPTIONS

alias java='java "${_SILENT_JAVA_OPTIONS}"'
