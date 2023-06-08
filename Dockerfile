FROM docker.io/library/archlinux:latest

RUN pacman --sync --sysupgrade --refresh --noconfirm dhcp && \
    rm --recursive --force /var/cache/pacman/pkg

ADD rootfs/ .

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]