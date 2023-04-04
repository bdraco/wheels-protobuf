# protobuf for Home Assistant

Build wheels for protobuf and Home Assistant.

## Manually building

A manual build can take a long time (4-5 hours or longer is normal).

To manually build the wheels using this Docker image:

```bash
docker build  --build-arg BUILD_FROM=ghcr.io/home-assistant/wheels/amd64/musllinux_1_2/cp310:2022.10.1 --build-arg BUILD_ARCH=amd64 --tag protobuf:amd64 .
docker build  --build-arg BUILD_FROM=ghcr.io/home-assistant/wheels/aarch64/musllinux_1_2/cp310:2022.10.1 --build-arg BUILD_ARCH=aarch64 --tag protobuf:aarch64 .
docker build  --build-arg BUILD_FROM=ghcr.io/home-assistant/wheels/armhf/musllinux_1_2/cp310:2022.10.1 --build-arg BUILD_ARCH=armhf --tag protobuf:armhf .
docker build  --build-arg BUILD_FROM=ghcr.io/home-assistant/wheels/armv7/musllinux_1_2/cp310:2022.10.1 --build-arg BUILD_ARCH=armv7 --tag protobuf:armv7 .
docker build  --build-arg BUILD_FROM=ghcr.io/home-assistant/wheels/i386/musllinux_1_2/cp310:2022.10.1 --build-arg BUILD_ARCH=i386 --tag protobuf:i386 .
```

If the build was successful, the wheel files can be extracted from the resulting
Docker images like so:

```bash
mkdir wheels
docker create --name protobuf protobuf:amd64 bash -c sleep 90000
docker cp "protobuf:/usr/src/wheels/." wheels
docker rm protobuf
```

The `wheels` folder now contains all the Python wheels.


