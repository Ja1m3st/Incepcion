#!/bin/sh

if id "$FTP_USER" &>/dev/null; then
    echo "El usuario $FTP_USER ya existe, omitiendo creación..."
else
    adduser -D -h "/home/$FTP_USER" -s /bin/false "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

mkdir -p "/home/$FTP_USER/ftp"
chown -R "$FTP_USER:$FTP_USER" "/home/$FTP_USER/ftp"
chmod -R 755 "/home/$FTP_USER/ftp"

{
    echo "seccomp_sandbox=$seccomp_sandbox"
    echo "listen=$listen"
    echo "pasv_min_port=$pasv_min_port"
    echo "pasv_max_port=$pasv_max_port"
    echo "anonymous_enable=$anonymous_enable"
    echo "write_enable=$write_enable"
    echo "local_enable=$local_enable"
    echo "chroot_local_user=$chroot_local_user"
    echo "allow_writeable_chroot=$allow_writeable_chroot"
} > /etc/vsftpd.conf

echo "$FTP_USER" > /etc/vsftpd.userlist

exec /usr/sbin/vsftpd /etc/vsftpd.conf