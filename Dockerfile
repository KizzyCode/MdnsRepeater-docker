# Build the binary
FROM alpine:latest AS buildenv
RUN apk add --no-cache build-base

COPY ./mdns-repeater /buildroot
# FIXME: Use `-Wextra` once https://github.com/kennylevinsen/mdns-repeater/issues/12 is fixed
RUN gcc -O3 -Wall -Werror -DHGVERSION="\"1\"" /buildroot/mdns-repeater.c -o /buildroot/mdns-repeater


# Build the real container
ARG EXTERNAL_INTERFACE
ARG DOCKER_INTERFACE

FROM alpine:latest
COPY --from=buildenv /buildroot/mdns-repeater /usr/local/bin/mdns-repeater

USER root
CMD ["/usr/local/bin/mdns-repeater", "-f", "${EXTERNAL_INTERFACE}", "${DOCKER_INTERFACE}"]
