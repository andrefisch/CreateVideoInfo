touch info.txt
touch info2.txt
directory=${PWD##*/}
ls *mp4 > vidlist.txt
perl C:/Users/anfis/OneDrive/Documents/CreateVideoInfo/createVideoInfo.pl $PWD
# when we load the names and places from a dictionary it adds a ^M which is the equivalent of \r at the end. this line removes all \r from a file
tr -d '\r' < info2.txt > info.txt
rm info2.txt
