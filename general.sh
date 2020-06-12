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

# # Change reserved percentage of the storage on ext4
# here 1 is the 1% of the storage
tune2fs -m 1 /dev/sdXY

# # Rate of something
tail -f /var/log/some.log | grep --line-buffered EVENT1 | pv -l > /dev/null


# # Remove ram cache buffer
# It clears PageCache, dentries and inodes
sync; echo 3 > /proc/sys/vm/drop_caches
# To clear PageCache only
sync; echo 1 > /proc/sys/vm/drop_caches
# To clear dentries and inodes
sync; echo 2 > /proc/sys/vm/drop_caches

# # Permission for mounted point
sudo chown seyed /media/files && sudo chmod u+rxw /media/files

# ##### Ansible #####

# # Add ssh key to machines
ansible cozet -m authorized_key -a 'user=seyed key="YOURKEY"' -u seyed -k

# # Run long duration ansible command, skip checking
ansible cozet -m shell -a 'ls -r' -u seyed -B 3 -P 0

# # Copy file from host to remote
ansible cozet -m copy -a 'src=~/Downloads/something.txt dest=/home/seyed/some.txt' -u seyed -f 16

# # Fetch ( akka Copy ) file from remote to host
ansible cozet -m fetch -a 'src=/home/seyed/1dayaccess.txt dest=/Users/invisible/ flat=true' -u seyed -f 16

# # Update minio with mc ( minio client )
# permission to replace the binary file
sudo chown -R miniouser:miniouser /usr/local/bin/
# set update env, I found that this is not neccessary
MINIO_UPDATE=on
systemctl daemon-reload
# update command with private mirror
mc admin update c3 http://192.168.2.32:8000/minio.sha256sum --debug


# # Export postgres query to csv
copy(select * from file_stats where bucket='cluster3') to '/tmp/cluster3.csv' With CSV DELIMITER ',';

# # Postgres Histogram query
select width_bucket(size, 1, 100000000, 50) as buckets, count(*) from file_stats where created_at >= '2020-04-07' AND created_at < '2020-04-08' AND size != 0 group by buckets order by buckets;


# # Monitor I/O performance
# bs:     block size
# count:  block count
# oflag:  don't cache
# For throughput
dd if=/dev/zero of=destination/test.txt bs=1G count=1 oflag=dsync
# For latency
dd if=/dev/zero of=destination/test.txt bs=512 count=1000 oflag=dsync


# # Generate random string
head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16

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