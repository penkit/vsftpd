FROM penkit/alpine:3.5

# start ftp server by default
CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]

# set vsftpd version from build arguments
ARG VSFTPD_VERSION
ENV VSFTPD_VERSION ${VSFTPD_VERSION}

# run setup script to install vsftpd
COPY vsftpd-setup.sh /usr/local/sbin/
RUN vsftpd-setup.sh

# copy config file for vsftpd
COPY vsftpd.conf /etc/vsftpd/
