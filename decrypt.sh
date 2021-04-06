echo "Enter password: "
read -s heslo
countimg=$(ls -1q decrypt/todecrypt/*.jpg | wc -l)
imgs=( $(ls -1q decrypt/todecrypt/*.jpg) )

        for ((i=0;i < $countimg;i++)){
                img=${imgs[$i]}
                encrypt=${toencrypt[$i]}
                steghide extract -sf $img -p $heslo
                img=( $(ls -1q *.jpg) )
                mv $img decrypt/decrypted/$img
        }
        
echo "Decrypting complete."
exit
