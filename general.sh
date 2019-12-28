# ##### Bash #####
# # Find files with 1 day last access with a postfix _complete
find /media/files -name *_completed -type f -atime -1 -exec ls {} \;



# ##### Ansible #####

# # Add ssh key to machines
ansible cozet -m authorized_key -a 'user=seyed key="YOURKEY"' -u seyed -k

# # Run long duration ansible command, skip checking
ansible cozet -m shell -a 'ls -r' -u seyed -B 3 -P 0

# # Copy file from host to remote
ansible cozet -m copy -a 'src=~/Downloads/something.txt dest=/home/seyed/some.txt' -u seyed -f 16

# # Fetch ( akka Copy ) file from remote to host
ansible cozet -m fetch -a 'src=/home/seyed/1dayaccess.txt dest=/Users/invisible/ flat=true' -u seyed -f 16