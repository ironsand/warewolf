killall omxplayer.bin
gatttool -b 78:A5:04:44:0A:57 --char-write-req -a 0x0028 -n dd
gatttool -b 78:A5:04:44:0A:57 --char-write-req -a 0x002b -n dd
gatttool -b 78:A5:04:44:0A:57 --char-write-req -a 0x0025 -n dd
omxplayer /home/pi/warewolf/BGM/morningBGM.mp3 &
