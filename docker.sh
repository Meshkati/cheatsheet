# # Change docker path
systemctl stop docker
ps aux | grep -i docker | grep -v grep
mkdir /new/path/to/docker
rsync -aqxPh --progress /var/lib/docker/ /new/path/to/docker
vim /etc/systemd/system/docker.service.d/docker-options
# now change the path on the options
systemctl daemon-reload
systemctl start docker
ps aux | grep -i docker | grep -v grep