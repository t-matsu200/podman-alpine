# podman-alpine

Enabled to use Podman in alpine image.

## Execute

The podman command can be replaced with the docker command.

```sh
$ podman build -t podman .

$ podman run -it --privileged podman sh

# run inside a container
$ buildah pull alpine

$ cat <<EOF > Dockerfile
FROM nginx:latest
CMD ['nginx', '-g', 'daemon off;']
EOF

$ buildah build -t test-nginx .
```

# Links

- https://github.com/containers/podman
- https://wiki.archlinux.jp/index.php/Podman#.E3.83.AB.E3.83.BC.E3.83.88.E3.83.AC.E3.82.B9_Podman
- https://www.redhat.com/sysadmin/podman-inside-container
- https://www.redhat.com/sysadmin/podman-inside-kubernetes
- https://rheb.hatenablog.com/entry/podman-in-podman
- https://rheb.hatenablog.com/entry/2020/07/16/podman_buidah_for_docker_users
- https://pkgs.alpinelinux.org/packages?name=podman
- https://github.com/containers/buildah
- https://buildah.io/
