FROM debian:latest

COPY upload /usr/local/bin
COPY removeVersion /usr/local/bin

ENTRYPOINT ["/usr/local/bin/upload"]
