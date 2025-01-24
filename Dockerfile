FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && apt install -y --no-install-recommends \
	build-essential \
	perl \
	gdb \
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
	openssh-server \
	xorriso \
	isolinux \
	syslinux-utils \
	genisoimage \
	tar \
	p7zip-full \
	software-properties-common \
	&& apt autoremove -y \
    	&& ln -sf $(which clang) $(which cc)

WORKDIR /root
