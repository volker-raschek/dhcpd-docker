FROM docker.io/library/archlinux:latest

RUN pacman --sync --sysupgrade --refresh --noconfirm dhcp

ADD rootfs/ .

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]