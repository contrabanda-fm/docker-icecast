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
docker run -d -p 8000:8000 ghcr.io/contrabanda-fm/docker-icecast
```

Supported ENV variables:

```
ICECAST_SOURCE_PASSWORD, ICECAST_ADMIN_PASSWORD, ICECAST_RELAY_PASSWORD
ICECAST_ADMIN_USERNAME, ICECAST_ADMIN_EMAIL
ICECAST_LOCATION, ICECAST_HOSTNAME
ICECAST_MAX_CLIENTS, ICECAST_MAX_SOURCES
```

# Credits

This project is a fork of [infiniteproject/icecast](https://github.com/infiniteproject/icecast)
