FROM mcr.microsoft.com/vscode/devcontainers/python:3

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        gnuplot \
        cloc

WORKDIR /opt
RUN git clone https://github.com/gktrk/gitstats.git

RUN wget https://s3.amazonaws.com/CodeMaatDistro/sample0.2.zip
RUN unzip sample02.zip \
    && mv sample "maat-sample"

RUN wget https://github.com/pmd/pmd/releases/download/pmd_releases%2F6.53.0/pmd-bin-6.53.0.zip
RUN unzip pmd-bin-6.53.0.zip \
    && ln -s /opt/pmd-bin-6.53.0/bin/run.sh /opt/pmd-bin-6.53.0/bin/pmd

RUN git clone https://github.com/adamtornhill/maat-scripts.git
WORKDIR /opt/maat-scripts
RUN git checkout python3 \
    && python -m pip install -r requirements.txt
