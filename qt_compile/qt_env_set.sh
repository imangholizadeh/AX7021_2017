#!/bin/sh
Cur_Dir=$(pwd)
echo $Cur_Dir
export QTDIR=$Cur_Dir
export QT_QPA_FONTDIR=$QTDIR/fonts
export QT_QPA_PLATFORM_PLUGIN_PATH=$QTDIR/plugins/
export QML2_IMPORT_PATH=$QTDIR/qml/
export LD_LIBRARY_PATH=$QTDIR:$LD_LIBRARY_PATH
export QT_QPA_PLATFORM=linuxfb


