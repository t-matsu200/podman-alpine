FROM docker.io/alpine:3.18

RUN apk update \
    && apk --no-cache add podman buildah skopeo \
    slirp4netns fuse-overlayfs curl jq shadow bash

RUN adduser -D podman \
    && echo -e "podman:1:999\npodman:1001:64535" > /etc/subuid \
    && echo -e "podman:1:999\npodman:1001:64535" > /etc/subgid

ADD containers.conf /etc/containers/containers.conf
ADD podman-containers.conf /home/podman/.config/containers/containers.conf

RUN mkdir -p /home/podman/.local/share/containers \
    && chown podman:podman -R /home/podman \
    && chmod 644 /etc/containers/containers.conf \
    && sed -e 's|^#mount_program|mount_program|g' \
    -e '/additionalimage.*/a "/var/lib/shared",' \
    -e 's|^mountopt[[:space:]]*=.*$|mountopt = "nodev,fsync=0"|g' \
    /usr/share/containers/storage.conf > /etc/containers/storage.conf

# Note VOLUME options must always happen after the chown call above
# RUN commands can not modify existing volumes
VOLUME /var/lib/containers
VOLUME /home/podman/.local/share/containers

RUN mkdir -p /var/lib/shared/overlay-images \
    /var/lib/shared/overlay-layers \
    /var/lib/shared/vfs-images \
    /var/lib/shared/vfs-layers && \
    touch /var/lib/shared/overlay-images/images.lock && \
    touch /var/lib/shared/overlay-layers/layers.lock && \
    touch /var/lib/shared/vfs-images/images.lock && \
    touch /var/lib/shared/vfs-layers/layers.lock

ENV _CONTAINERS_USERNS_CONFIGURED=""

CMD ["sh"]
