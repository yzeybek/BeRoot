FROM ubuntu:latest

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get install -y \
	build-essential \
	perl \
	automake \
	clang \
	valgrind \
	libbsd-dev \
	lsb-release \
	git \
	curl \
	python3 \
	python3-setuptools \
	python3-pip \
	pipx \
	sudo \
	vim \
	wget \
	gpg \
	jq \
	x11-apps \
	inotify-tools \
	software-properties-common \
	&& apt-get clean autoclean \
    && apt-get autoremove --yes

WORKDIR /root

CMD ['wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
	&& install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
	&& echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null \
	&& rm -f packages.microsoft.gpg \
	&& apt install apt-transport-https -y \
	&& apt update -y \
	&& apt install code -y']

ENTRYPOINT ["/usr/bin/bash"]
