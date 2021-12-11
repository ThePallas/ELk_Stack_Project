#!/bin/bash

#define variables
ip_address=$(ip addr | grep inet | tail -2 | head -1)
files=('/etc/passwd' '/etc/shadow')


# looks for reasearch directory and creates it if it does not exist
if [! -d ~/research]
then
  mkdir ~/research
fi
# Deletes sys_info.txt file if it exists
if [! -f ~/research/sys_info.txt]
then
  rm ~/research/sys_info.txt
fi


echo "A Quick System Audit Script" >  ~/research/sys_info.txt
date >> ~/research/sys_info.txt
echo "" >> ~/research/sys_info.txt
echo "Machine Type Info:" >> ~/research/sys_info.txt
echo $MACHTYPE >> ~/research/sys_info.txt
echo -e "Uname info: $(uname -a) \n" >> ~/research/sys_info.txt
echo -e "IP Info: $ip_address \n" >> ~/research/sys_info.txt

#echo -e "IP Info: $(ip addr | grep inet | tail -2 | head -1) \n" >> ~/research/sys_info.txt
echo "Hostname: $(hostname -s) " >> ~/research/sys_info.txt
echo -e "\n777 Files:" >>  ~/research/sys_info.txt
find / -type f -perm 777 >> ~/research/sys_info.txt
echo -e "\nTop 10 Processes" >> ~/research/sys_info.txt
ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> ~/research/sys_info.txt
# lists permissions for each file in files list
for item in ${files[@]}; do
  ls -l $item
done
#check sudo permissions for all users in home directory
for user in $(ls /home);
do
  sudo -l -U $user
done

commands=('date' 'uname -a' 'hostname -s')
for numcommand item in ${0..2};
do
  results=$({commands[$numcommand]})
  echo "The results of the $item command are:"
  echo $results
done


#echo "Hello $name. This is a system audit."
#echo -e "\nToday is: $(date).\n"
#echo -e "\nuname is: $(uname -a).\n"
#echo -e "\nip address is: $(ip addr |grep inet|tail -2| head -1).\n"
#echo -e "\nip address is: $(hostname -I).\n"

#echo -e "\nHostname is: $(hostname).\n"

#echo -e "\nDNS is: $(hostname -s).\n"
#echo -e "\nHostname is: $(hostname -I).\n"
#echo -e "\nHostname is: $(hostname).\n"
#echo -e "\nHostname is: $(hostname).\n"

