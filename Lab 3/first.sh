#!/bin/sh

#1
cat /etc/passwd | awk -F ':' '{print "user "$1 " has id "$3}' > work3.log

#2
chage -l root | grep "Last password change" >> work3.log

#3
cat /etc/group | awk -F ':' '{print $1}' ORS=", " >> work3.log

#4
echo "Be careful!" > /etc/skel/readme.txt

#5
useradd u1 -p $(openssl passwd -crypt 12345678)

#6
groupadd g1

#7
usermod -aG g1 u1

#8
id u1 | awk -F ' ' '{print $1" "$3}' >> work3.log

#9
usermod -aG g1 user

#10
cat /etc/group | grep "g1" | awk -F ':' '{print $4}' >> work3.log

#11
usermod u1 -s /usr/bin/mc

#12
useradd u2 -p $(openssl passwd -crypt 87654321)

#13
mkdir /home/test13
cp work3.log /home/test13/work3-1.log
cp work3.log /home/test13/work3-2.log

#14
usermod -aG g1 u2
chown -R u1 /home/test13/
chgrp -R g1 /home/test13/
chmod u=rwx,g=r,o= /home/test13/

#15
mkdir /home/test14
chown -R u1:u1 /home/test14/
chmod +t /home/test14/

#16
cp /bin/nano /home/test14/nano
chmod u+s /home/test14/nano

#17
mkdir /home/test15
echo "l;askdsl;afklsdjf" > /home/test15/secret_file
chmod a-r /home/test15/
