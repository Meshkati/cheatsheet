# ##### Bash #####
# # Find files with 1 day last access with a postfix _complete
find /media/files -name *_completed -type f -atime -1 -exec ls {} \;

# # Sum all of the columns in a file
# in paste -s shows serial and -d adds a delimiter
# bc sums up the numbers
cat ll.log | cut -d " " -f 5 | paste -sd+ | bc

# # Convert bytes to human readable
echo "12345" | numfmt --to=iec-i

# # Remove files in one file from another file
# -F for matching string instead of regex
# -v for not containing ( Necessary )
# -x whole line match
# -f read from file
grep -Fvx -f partial.list complete.list >remaining.list


# ##### Ansible #####

# # Add ssh key to machines
ansible cozet -m authorized_key -a 'user=seyed key="YOURKEY"' -u seyed -k

# # Run long duration ansible command, skip checking
ansible cozet -m shell -a 'ls -r' -u seyed -B 3 -P 0

# # Copy file from host to remote
ansible cozet -m copy -a 'src=~/Downloads/something.txt dest=/home/seyed/some.txt' -u seyed -f 16

# # Fetch ( akka Copy ) file from remote to host
ansible cozet -m fetch -a 'src=/home/seyed/1dayaccess.txt dest=/Users/invisible/ flat=true' -u seyed -f 16


# ##### Scripts #####
# # Read lines and do something
#!/bin/bash
input="/home/elenoon/hot-25m-7d/file_id.txt"
var=1
while IFS= read -r line
do
  echo "step "$var
  prefix=$(echo "$line"|cut -d '/' -f 3)
  fileid=$(echo "$line"|cut -d '/' -f 4)
  # making prefix directory
  mkdir -p "/media/file/minioserver/cold/"$prefix
  # moving to prefix directories
  mv "/media/file/minioserver/cold/"$fileid "/media/file/minioserver/cold/"$prefix"/"$fileid
  var=$((var+1))
  echo
done < "$input"