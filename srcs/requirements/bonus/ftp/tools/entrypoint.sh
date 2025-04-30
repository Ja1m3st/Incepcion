#!/bin/sh

# Instalar paquetes necesarios si no existen
if [ -f /etc/vsftpd.configured ]; then
    exec /usr/sbin/vsftpd /etc/vsftpd.conf
    exit 0
fi

# Validar variables
if [ -z "$FTP_USER" ] || [ -z "$FTP_PASSWORD" ]; then
    echo "ERROR: FTP_USER o FTP_PASSWORD no definidas" >&2
    exit 1
fi

# Configurar usuario
adduser -D -h "/home/$FTP_USER" -s /bin/false "$FTP_USER"
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

# Configurar directorio
mkdir -p "/home/$FTP_USER/ftp"
chown -R "$FTP_USER:$FTP_USER" "/home/$FTP_USER/ftp"
chmod -R 755 "/home/$FTP_USER/ftp"

# Configuración final de vsftpd
{
    echo "$seccomp_sandbox" >> /etc/vsftpd.conf
    echo "$listen" >> /etc/vsftpd.conf
    echo "$pasv_min_port"
    echo "$pasv_max_port"
    echo "$anonymous_enable"
    echo "$write_enable"
    echo "$local_enable"
    echo "$chroot_local_user"
    echo "$allow_writeable_chroot"
} >> /etc/vsftpd.conf

echo "$FTP_USER" > /etc/vsftpd.userlist

# Ejecutar en primer plano (importante para Docker)
exec /usr/sbin/vsftpd /etc/vsftpd.conf