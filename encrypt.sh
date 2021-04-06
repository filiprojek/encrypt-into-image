#!/bin/bash
echo "Enter password: "
read -s heslo
echo "Re-enter password: "
read -s heslo2
if [ $heslo == $heslo2 ]; then
	countimg=$(ls -1q encrypt/toencrypt/coverimages/*.jpg | wc -l)
	imgs=( $(ls -1q encrypt/toencrypt/coverimages/*.jpg) )
	counttoencrypt=$(ls -1q encrypt/toencrypt/*.jpg | wc -l)
	toencrypt=( $(ls -1q encrypt/toencrypt/*.jpg) )

	if [ $countimg == $counttoencrypt ]; then
		echo ""
		echo "Wait until encryption is complete."
		for ((i=0;i < $countimg;i++)){
				img=${imgs[$i]}
				encrypt=${toencrypt[$i]}
				steghide embed -e rijndael-256 -cf $img -ef $encrypt -p $heslo
				export VAR=$img && imgnm=( $(echo "${VAR##*/}") )
				mv $img encrypt/encrypted/$imgnm
				rm $encrypt
		}
		echo ""
		echo ""
		echo "Encrypting completed successfully."
		exit
	else
		echo  "Error - the number of pictures to be encrypted must be equal to the number of pictures to be covered!"
		exit
	fi
else
	echo "Error - the password does not match!"
	exit
fi
