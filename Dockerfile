# syntax=docker/dockerfile:1
# https://hub.docker.com/_/alpine
FROM alpine:3.19.1

# renovate: datasource=repology depName=alpine_3_19/libcurl versioning=loose
ENV LIBCURL_VERSION="8.5.0-r0"
# renovate: datasource=repology depName=alpine_3_19/tzdata versioning=loose
ENV TZDATA_VERSION="2024a-r0"

ENV TZ=Europe/Paris

WORKDIR /
RUN apk update
RUN apk add libcurl=${LIBCURL_VERSION}
RUN apk add tzdata=${TZDATA_VERSION}
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone

