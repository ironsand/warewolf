killall omxplayer.bin
gatttool -b 78:A5:04:44:0A:57 --char-write-req -a 0x0025 -n 00
gatttool -b 78:A5:04:44:0A:57 --char-write-req -a 0x002b -n ff
gatttool -b 78:A5:04:44:0A:57 --char-write-req -a 0x0028 -n 00
omxplayer /home/pi/warewolf/BGM/nightBGM.mp3 &
