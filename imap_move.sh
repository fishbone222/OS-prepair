CSV=$(realpath $1)
cd /tmp
git clone https://github.com/imapsync/imapsync
cd imapsync
while IFS=, read -r host1 user1 password1 server2 user2 password2; do
   imapsync --host1 $host1 --user1 $user1 --password1 $password1 --host2 $host2 --user2 $user2 --password2 $password2
done < $CSV
