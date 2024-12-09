FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get install -y --no-install-recommends \
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
	dbus-x11 \
	gpg-agent \
	libnotify4 \
	openjdk-8-jre \
	openjfx \
	nano \
	iputils-ping \
	software-properties-common \
	&& apt-get clean autoclean \
    	&& apt-get autoremove --yes \
    	&& ln -sf $(which clang) $(which cc)

WORKDIR /root
