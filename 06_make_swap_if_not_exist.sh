#dd if=/dev/zero of=/mnt/512MiB.swap bs=1024 count=524288
dd if=/dev/zero of=/mnt/file.swap bs=1024 count=1048576
chmod 600 /mnt/file.swap
mkswap /mnt/file.swap
swapon /mnt/file.swap 
echo "/mnt/file.swap none swap sw 0 0" >> /etc/fstab
