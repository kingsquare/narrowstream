FROM hypriot/rpi-node:slim

RUN apt-get update && \
    apt-get install -y \
        git-core \
        wget \
        python

WORKDIR /app