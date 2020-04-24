export GOPATH=$HOME/.go

# Update PATH
export PATH=$PATH:$HOME/.cargo/bin:$HOME/.local/bin

# Qt look and feel
# [[ $XDG_CURRENT_DESKTOP != 'KDE' ]] && export QT_QPA_PLATFORMTHEME='qt5ct'

# Use GTK2 theme for Java applications
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
