FROM mcr.microsoft.com/vscode/devcontainers/python:3

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        gnuplot \
        cloc

WORKDIR /opt
RUN git clone https://github.com/gktrk/gitstats.git
