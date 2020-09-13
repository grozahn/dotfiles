# [ -f ~/.bashrc ] && source ~/.bashrc

export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin"
export GOPATH="$HOME/.go"

# Qt look and feel
[[ $XDG_CURRENT_DESKTOP != 'KDE' && $XDG_CURRENT_DESKTOP != 'LXQt' ]] && export QT_QPA_PLATFORMTHEME='qt5ct'

# Use GTK2 theme for Java applications
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

