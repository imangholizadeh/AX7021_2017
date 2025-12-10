# AX7021_2017



note:
https://forum.qt.io/topic/98556/setting-up-qt-with-zynq
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842110/Qt+Qwt+Build+Instructions+Qt+5.4.2+Qwt+6.1.2




root@Petalinux_LCD_Terminal:~# dmesg | grep i2c
i2c /dev entries driver
cdns-i2c e0004000.i2c: 100 kHz mmio e0004000 irq 22
cdns-i2c e0005000.i2c: 100 kHz mmio e0005000 irq 23

  
root@Petalinux_LCD_Terminal:~# i2cdetect -r -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f  
     
00:          -- -- -- -- -- -- -- -- -- -- -- -- --  
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --  
70: -- -- -- -- -- -- -- --  
root@Petalinux_LCD_Terminal:~#  
