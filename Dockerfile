FROM debian:latest

COPY upload.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/upload.sh"]
