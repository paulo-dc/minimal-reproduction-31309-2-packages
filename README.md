# minimal-reproduction-31309
How to configure renovate to update image version and package version at the same time to maintain an alpine docker image

## Current behavior

With my current renovate.json configuration I get this MR :

| Package | Type | Update | Change |
|---|---|---|---|
| alpine_3_19/libcurl |  | minor | `8.5.0-r0` -> `8.9.1-r0` |
| dockerproxy.repos.tech.orange/alpine |  | minor | `3.19` -> `3.20` |
| dockerproxy.repos.tech.orange/alpine | final | minor | `3.19.1` -> `3.20.3` |

And a proposal to update the Dockerfile to :

```dockerfile
# syntax=docker/dockerfile:1
# https://hub.docker.com/_/alpine
FROM alpine:3.20.3

# renovate: datasource=repology depName=alpine_3_20/libcurl versioning=loose
ENV LIBCURL_VERSION="8.9.1-r0"
# renovate: datasource=repology depName=alpine_3_20/tzdata versioning=loose
ENV TZDATA_VERSION="2024a-r0"

ENV TZ=Europe/Paris

WORKDIR /
RUN apk update
RUN apk add libcurl=${LIBCURL}
RUN apk add tzdata=${TZDATA}
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone
```

## Expected behavior

I would like to have this instead:

The MR should contain the following updates:

| Package | Type | Update | Change |
|---|---|---|---|
| alpine_3_20/libcurl |  | minor | `8.5.0-r0` -> `8.9.1-r1` |
| alpine_3_20/tzdata |  | patch | `2024a-r0` -> `2024b-r0` |
| dockerproxy.repos.tech.orange/alpine |  | minor | `3.19` -> `3.20` |
| dockerproxy.repos.tech.orange/alpine | final | minor | `3.19.1` -> `3.20.3` |

And a proposal for the dockerfile like that:

```dockerfile
# syntax=docker/dockerfile:1
# https://hub.docker.com/_/alpine
FROM alpine:3.20.3

# renovate: datasource=repology depName=alpine_3_20/libcurl versioning=loose
ENV LIBCURL_VERSION="8.9.1-r1"
# renovate: datasource=repology depName=alpine_3_20/tzdata versioning=loose
ENV TZDATA_VERSION="2024b-r0"

ENV TZ=Europe/Paris

WORKDIR /
RUN apk update
RUN apk add libcurl=${LIBCURL}
RUN apk add tzdata=${TZDATA}
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone
```

## Link to the Renovate issue or Discussion

[https://github.com/renovatebot/renovate/discussions/31309](https://github.com/renovatebot/renovate/discussions/31309)