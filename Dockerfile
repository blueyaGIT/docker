FROM ubuntu:22.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install required packages including git
RUN apt-get update && \
    apt-get install -y \
        software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y \
        valgrind \
		xz-utils \
		git-all \
		git-core \
		sudo \
		build-essential \
		cmake \
        make \
        gcc \
        g++ \
		libcppunit-dev \
    	zsh \
        bash \
        curl \
        python3-pip \
		python-dev-is-python3 \
		python3.10-venv \
        nano \
		libreadline-dev \
        git && \
    apt-get clean

WORKDIR /app

COPY ../ /app

# Customize bash prompt
RUN echo 'PS1="\[\033[34m\]dev_container: \w# \[\033[0m\]"' >> /etc/bash.bashrc \
	python3 -m pip install --upgrade pip setuptools && \
	python3 -m pip install norminette

CMD ["bash"]