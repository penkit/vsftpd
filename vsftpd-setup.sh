#!/bin/sh
set -ex

# create vsftpd system user
addgroup vsftpd
adduser -S -G vsftpd vsftpd

# install vsftpd server
apk add --no-cache \
  vsftpd=$VSFTPD_VERSION

# self destruct
rm -- "$0"
