<!-- START doctoc.sh generated TOC please keep comment here to allow auto update -->
<!-- DO NOT EDIT THIS SECTION, INSTEAD RE-RUN doctoc.sh TO UPDATE -->
**:book: Table of Contents**

- [docker-icecast](#docker-icecast)
- [Usage](#usage)
- [Credits](#credits)

<!-- END doctoc.sh generated TOC please keep comment here to allow auto update -->
# docker-icecast

Docker image for [Icecast 2](https://icecast.org/)

# Usage

```
docker run \
    --name icecast \
    -e ICECAST_SOURCE_PASSWORD=sourcesecret \
    -e ICECAST_ADMIN_PASSWORD=adminsecret \
    -e ICECAST_RELAY_PASSWORD=relaysecret \
    -e ICECAST_ADMIN_USERNAME=myuser \
    -e ICECAST_MOUNT_1_MOUNT_NAME="/contrabanda" \
    -e ICECAST_MOUNT_1_PASSWORD="mountsecret" \
    -e ICECAST_MOUNT_1_MAX_LISTENERS="900" \
    -e ICECAST_MOUNT_1_MAX_LISTENER_DURATION="36000" \
    -e ICECAST_MOUNT_1_STREAM_NAME="Contrabanda FM" \
    -e ICECAST_MOUNT_1_STREAM_DESCRIPTION="Radio Lliure i Autogestionada de Barcelona" \
    -e ICECAST_MOUNT_1_STREAM_URL="https://www.contrabanda.org" \
    -e ICECAST_MOUNT_1_GENRE="RadioLliure" \
    -e ICECAST_MOUNT_1_BITRATE="96" \
    -e ICECAST_MOUNT_2_MOUNT_NAME="/carrer" \
    -e ICECAST_MOUNT_2_PASSWORD="mount2secret" \
    -e ICECAST_MOUNT_2_MAX_LISTENERS="100" \
    -e ICECAST_MOUNT_2_MAX_LISTENER_DURATION="36000" \
    -e ICECAST_MOUNT_2_STREAM_NAME="Contrabanda FM" \
    -e ICECAST_MOUNT_2_STREAM_DESCRIPTION="Canal per emissions al carrer de Contrabanda FM" \
    -e ICECAST_MOUNT_2_STREAM_URL="https://www.contrabanda.org" \
    -e ICECAST_MOUNT_2_GENRE="RadioLliure" \
    -e ICECAST_MOUNT_2_BITRATE="96" \
    -p 8000:8000 \
    -d \
    ghcr.io/contrabanda-fm/docker-icecast
```

Supported ENV variables:

* For general settings:

```
ICECAST_ADMIN_EMAIL
ICECAST_ADMIN_PASSWORD
ICECAST_ADMIN_USERNAME
ICECAST_HOSTNAME
ICECAST_LOCATION
ICECAST_MAX_CLIENTS
ICECAST_MAX_SOURCES
ICECAST_RELAY_PASSWORD
ICECAST_SOURCE_PASSWORD
```

* For each one of mount point start variable with "ICECAST_MOUNT_X" where "X" its an integer from 1 onwards:

```
ICECAST_MOUNT_1_MOUNT_NAME
ICECAST_MOUNT_1_PASSWORD
ICECAST_MOUNT_1_MAX_LISTENERS
ICECAST_MOUNT_1_MAX_LISTENER_DURATION
ICECAST_MOUNT_1_STREAM_NAME
ICECAST_MOUNT_1_STREAM_DESCRIPTION
ICECAST_MOUNT_1_STREAM_URL
ICECAST_MOUNT_1_GENRE
ICECAST_MOUNT_1_BITRATE
```

# Credits

This project is a fork of [infiniteproject/icecast](https://github.com/infiniteproject/icecast)
