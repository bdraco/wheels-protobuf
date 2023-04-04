# protobuf for Home Assistant

Build wheels for protobuf and Home Assistant.

## Manually building

A manual build can take a long time (4-5 hours or longer is normal).

To manually build the wheels using this Docker image:

```bash
docker build  --build-arg BUILD_FROM=ghcr.io/home-assistant/wheels/amd64/musllinux_1_2/cp310:2022.10.1 --build-arg BUILD_ARCH=amd64 --tag protobuf:amd64 .
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

## Caveats

Using a lot of resources to speed up the build usually leads to failed builds.
For example, building with 32Gb mem and 16 AMD Ryzen 7 cores just fails faster.

Tests showed running with 16Gb of memory with 4 cores, does the job relatively
fast and stable.
