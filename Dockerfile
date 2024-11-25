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

RUN pipx install norminette && pipx ensurepath \
	&& python3 -m pip config set global.break-system-packages true \
	&& pip3 install c_formatter_42 \
	&& bash -c "$(curl -fsSL https://raw.github.com/xicodomingues/francinette/master/bin/install.sh)"
	
CMD ["/usr/bin/bash"]
