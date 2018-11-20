FROM debian:latest

RUN apt update 				&& \
	apt install -q -y curl	&& \
	rm -rf /var/lib/apt/lists

COPY upload /usr/local/bin
COPY removeVersion /usr/local/bin

ENTRYPOINT ["/usr/local/bin/upload"]
