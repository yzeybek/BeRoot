FROM ubuntu:24.04

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
