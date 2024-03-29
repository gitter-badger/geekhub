FROM ubuntu:latest
MAINTAINER Adham eldeeb <adham.eldeeb90@gmail.com>

# Just use bash.
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Debian complatins about the terminal env on Docker. Use this.
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install bash packages
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y curl wget ca-certificates build-essential autoconf python-software-properties libyaml-dev

# Finish installing remaning dependencies
RUN apt-get install -y libssl-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev bison openssl make git libpq-dev libsqlite3-dev nodejs
RUN apt-get clean

# Force sudoers to not being asked the password
RUN echo %sudo          ALL=NOPASSWD: ALL >> /etc/sudoers

# Ruby-install
RUN wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz && tar -xzvf ruby-install-0.5.0.tar.gz && cd ruby-install-0.5.0/ && make install

# chruby
RUN wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz && tar -xzvf chruby-0.3.9.tar.gz && cd chruby-0.3.9/ && make install

RUN rm -rf /var/cache/apt/* /tmp/*

# Add a user just for running the app
RUN useradd -m -G sudo app

USER app
WORKDIR /home/app

# Install a Ruby version
RUN ruby-install ruby
RUN rm -rf /home/app/src

ADD docker-entrypoint.sh /home/app/docker-entrypoint.sh
ADD setup.sh /home/app/setup.sh

ENV RAILS_ENV=production

EXPOSE 3000:3000

ENTRYPOINT /home/app/docker-entrypoint.sh