# This dockerfile is heavily based on Nick Merwin's, which is available at
# https://gist.github.com/nickmerwin/3bd36e82523274f3e54212a3fb095e32

#FROM thomasweise/docker-texlive-thin
FROM ubuntu:20.04
#FROM phusion/baseimage:latest

ENV HOME /root
#RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
#CMD ["/sbin/my_init"]

# ==============================================================================
# install deps
# ==============================================================================
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
RUN mkdir -p /usr/share/man/man1 && apt-get update \
  && apt-get install -y ruby gems g++ ruby-dev curl \
  libcurl4-gnutls-dev nodejs default-jre python3 python3-pip imagemagick \
  inkscape calibre texlive-full ttf-mscorefonts-installer \
  && fc-cache -f -v
WORKDIR /root

# ==============================================================================
# install phantomjs
# ==============================================================================
COPY vendor/phantomjs-2.1.1-linux-x86_64.tar.bz2 /root
RUN tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share \
  && ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin \
  && rm phantomjs-2.1.1-linux-x86_64.tar.bz2

# ==============================================================================
# install epubcheck
# ==============================================================================
COPY vendor/epubcheck-4.2.2.zip /root
RUN unzip epubcheck-4.2.2.zip -d bin && rm epubcheck-4.2.2.zip

# ==============================================================================
# install kindlegen
# ==============================================================================
COPY vendor/kindlegen_linux_2.6_i386_v2_9.tar.gz /root
RUN tar -zxvf kindlegen_linux_2.6_i386_v2_9.tar.gz \
  && rm kindlegen_linux_2.6_i386_v2_9.tar.gz \
  && cd /usr/local/bin \
  && ln -s ~/kindlegen_linux_2.6_i386_v2_9/kindlegen kindlegen

# ==============================================================================
# softcover gem
# ==============================================================================
RUN apt-get install -y libxslt-dev libxml2-dev build-essential zlib1g-dev
RUN gem install softcover
# ==============================================================================
# sphinx
# ==============================================================================
pip install sphinx myst_parser
# ==============================================================================
# Health check
# ==============================================================================
ENV PATH="$PATH:/root:/root/bin"
ENV XDG_RUNTIME_DIR="/tmp"
ENV QT_QPA_PLATFORM="phantom"
RUN softcover check

# ==============================================================================
# Ready to run
# ==============================================================================
RUN mkdir /book
WORKDIR /book

EXPOSE 4000

# from book directory build html:
# $ docker run -v `pwd`:/book softcover:latest sc build:html

# run server:
# $ docker run -v `pwd`:/book -d -p 4000:4000 softcover:latest sc server
