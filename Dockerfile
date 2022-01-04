# Build the binary
FROM alpine:latest AS buildenv
RUN apk add --no-cache build-base

COPY ./mdns-repeater /buildroot
# FIXME: Use `-Wextra` once https://github.com/kennylevinsen/mdns-repeater/issues/12 is fixed
RUN gcc -O3 -Wall -Werror -DHGVERSION="\"1\"" /buildroot/mdns-repeater.c -o /buildroot/mdns-repeater


# Build the real container
FROM alpine:latest
COPY --from=buildenv /buildroot/mdns-repeater /libexec/mdns-repeater
COPY ./mdns-repeater.sh /sbin/mdns-repeater

USER root
CMD ["/sbin/mdns-repeater"]
