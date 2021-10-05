#!/bin/sh

# Perform a cleanup of previous script use
rm -rf /home/user/test
rm -f /home/user/list1
rm -rf /root/man.dir

#1
mkdir /home/user/test

#2
output=/home/user/test/list
ls -laF /etc/ > $output

#3
dirCount=$(find /etc/* -maxdepth 0 -type d | wc -l)
echo "The number of directories in /etc/: $dirCount" >> $output
hiddenCount=$(find /etc/ -maxdepth 1 -type f -iname ".*" -ls | wc -l)
echo "The number of hidden files in /etc/: $hiddenCount" >> $output

#4
mkdir /home/user/test/links

#5
ln /home/user/test/list /home/user/test/links/list_hlink

#6
ln -s /home/user/test/list /home/user/test/links/list_slink

#7
listHLCount=$(ls -liaF /home/user/test/ | grep "list" | awk '{print $3}')
echo "The number of hard links to /home/user/test/list is: $listHLCount"
listhHLCount=$(ls -liaF /home/user/test/links | grep "list_hlink" | awk '{print $3}')
echo "The number of hard links to /home/user/test/links/list_hlink is: $listhHLCount"
listsHLCount=$(ls -liaF /home/user/test/links | grep "list_slink" | awk '{print $3}')
echo "The number of hard links to /home/user/test/links/list_slink is: $listsHLCount"
# Explanation: https://bertvv.github.io/notes-to-self/2015/10/18/the-number-of-hard-links-in-ls--l/

#8
listLinesCount=$(cat /home/user/test/list | wc -l)
echo "The number of lines in /home/user/test/list is: $listLinesCount" >> /home/user/test/links/list_hlink

#9
checkDiff=$(diff -s /home/user/test/links/list_hlink /home/user/test/links/list_slink | grep -o "identical")
if [[ $checkDiff == "identical" ]]
then
	echo "YES (list_hlink and list_slink are identical)"
else
	echo "NO"
fi
# Both list_hlink and list_slink are identical,
# list_hlink is an exact copy of list,
# while list_slink is just a pointer to list

#10
mv /home/user/test/list /home/user/test/list1

#11
checkDiff=$(diff -s /home/user/test/links/list_hlink /home/user/test/links/list_slink | grep -o "identical")
if [[ $checkDiff == "identical" ]]
then
        echo "YES (list_hlink and list_slink are identical)"
else
	echo "NO"
fi
# After renaming list to list1, the soft link cannot point anymore
# to the original file, so the files cannot be compared

#12
ln /home/user/test/links/list_hlink /home/user/list1

#13
find /etc/ -type f -name "*.conf" > /home/list_conf

#14
find /etc/ -type d -name "*.d" > /home/list_d

#15
cat /home/list_conf > /home/list_conf_d
cat /home/list_d >> /home/list_conf_d

#16
mkdir /home/user/test/.sub

#17
cp /home/list_conf_d /home/user/test/.sub/list_conf_d

#18
cp -b /home/list_conf_d /home/user/test/.sub/list_conf_d

#19
find /home/user/test -ls

#20
man man > /home/man.txt

#21
split -b 1024 /home/man.txt

#22
mkdir /root/man.dir

#23
mv /root/Lab1/x* /root/man.dir

#24
cat /root/man.dir/x* > /root/man.dir/man.txt

#25
checkDiff=$(diff -s /home/man.txt /root/man.dir/man.txt | grep -o "identical")
if [[ $checkDiff == "identical" ]]
then
        echo "YES (man.txt files are identical)"
else
        echo "NO"
fi

#26
echo -e "New line\nNew line\nNew line\n$(cat /home/man.txt)" > /home/man.txt
echo -e "New line\nNew line\nNew line\n" >> /home/man.txt

#27
diff -u /home/man.txt /root/man.dir/man.txt > /root/man.dir/difference

#28
mv /home/man.txt /root/man.dir/man.txt2

#29
patch /root/man.dir/man.txt /root/man.dir/difference

#30
checkDiff=$(diff -s /root/man.dir/man.txt /root/man.dir/man.txt2 | grep -o "identical")
if [[ $checkDiff == "identical" ]]
then
        echo "YES (man.txt and man.txt2 are identical)"
else
        echo "NO"
fi
# Explanation: https://www.pair.com/support/kb/paircloud-diff-and-patch/
