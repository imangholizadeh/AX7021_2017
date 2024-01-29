#!/bin/sh
SDK_PATH=/opt/Xilinx/SDK/2017.4
if [ ! -d $SDK_PATH ]; then
  echo "no dir ${SDK_PATH}"
  exit 1
fi
Cur_Dir=$(pwd)
source ${SDK_PATH}/settings64.sh
export ZYNQ_QT_INSTALL=${Cur_Dir}/build
export PKG_CONFIG_LIBDIR=${SDK_PATH}/gnu/aarch32/lin/gcc-arm-linux-gnueabi/arm-linux-gnueabihf/lib
export CROSS_COMPILE=arm-linux-gnueabihf-

if [ ! -d $PKG_CONFIG_LIBDIR ]; then
  echo "no ${PKG_CONFIG_LIBDIR}"
  exit 1
fi
Cur_Dir=$(pwd)
QT_SORCE=qt-everywhere-src-5.14.1
echo $Cur_Dir
export ZYNQ_QT_BUILD=$Cur_Dir
export PATH=$ZYNQ_QT_INSTALL/bin:$PATH
cd $QT_SORCE
./configure -xplatform arm-linux-gnueabihf-g++ \
    -opensource \
    -confirm-license \
   -skip qtquick3d \
-no-opengl \
    -prefix $ZYNQ_QT_INSTALL
make -j4
sudo make install
sudo cp $Cur_Dir/qt_env_set.sh  $ZYNQ_QT_INSTALL/qt_env_set.sh
