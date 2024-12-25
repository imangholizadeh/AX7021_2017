 -------------------------------------------------------------------------------------
#for compile .cpp file

sudo apt-get update
sudo apt-get install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf

#then run:
arm-linux-gnueabihf-gcc -o app new.c
-------------------------------------------------------------------------------------
 source /tools/Xilinx/Vivado/2020.1/settings64.sh
 arm-linux-gnueabihf-gcc -o app gpio_test.cpp 
-------------------------------------------------------------------------------------
