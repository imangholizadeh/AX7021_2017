#!/bin/sh
Cur_Dir=$(pwd)
export ZYNQ_QT_INSTALL=${Cur_Dir}/build
export PKG_CONFIG_LIBDIR=/opt/Xilinx/SDK/2017.4/gnu/aarch32/lin/gcc-arm-linux-gnueabi/arm-linux-gnueabihf/lib
if [ ! -d $ZYNQ_QT_INSTALL ]; then
  echo "no ${ZYNQ_QT_INSTALL}"
  exit 1
fi
if [ ! -d $PKG_CONFIG_LIBDIR ]; then
  echo "no ${PKG_CONFIG_LIBDIR}"
  exit 1
fi
Cur_Dir=$(pwd)
LIBS_NAME=zynq_qt_lib
mkdir $LIBS_NAME
sudo cp $ZYNQ_QT_INSTALL/lib/*.so* $Cur_Dir/$LIBS_NAME
sudo cp -R $ZYNQ_QT_INSTALL/plugins $Cur_Dir/$LIBS_NAME
sudo cp -R $ZYNQ_QT_INSTALL/qml $Cur_Dir/$LIBS_NAME
sudo cp $PKG_CONFIG_LIBDIR/libstdc++.so* $Cur_Dir/$LIBS_NAME
sudo cp $PKG_CONFIG_LIBDIR/libgcc_s.so* $Cur_Dir/$LIBS_NAME
cp -R fonts $Cur_Dir/$LIBS_NAME
cp $Cur_Dir/qt_env_set.sh $Cur_Dir/$LIBS_NAME
sudo chmod 777 $Cur_Dir/$LIBS_NAME -R
sudo dd if=/dev/zero of=qt_lib.img bs=1M count=400
sudo mkfs.ext4 -F qt_lib.img
sudo chmod go+w qt_lib.img
sudo mount qt_lib.img -o loop /mnt
sudo cp -rf $Cur_Dir/$LIBS_NAME/* /mnt
sudo chmod go-w qt_lib.img
sudo umount /mnt
