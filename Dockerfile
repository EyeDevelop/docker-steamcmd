FROM ubuntu:20.04

# Install dependencies.
RUN apt-get update && apt-get install -y software-properties-common bash
RUN add-apt-repository multiverse &&\
    dpkg --add-architecture i386 &&\
    apt-get update &&\
    echo 2 | apt-get install -y steamcmd libsdl2-2.0-0:i386 lib32gcc1 libcurl3-gnutls:i386 || true

# Environment variables available.
ENV PUID 1000
ENV PGID 1000
ENV STEAM_APPID 0

# Add entrypoint.
COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
