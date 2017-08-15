# This dockerfile is heavily based on Nick Merwin's, which is available at
# https://gist.github.com/nickmerwin/3bd36e82523274f3e54212a3fb095e32

FROM phusion/baseimage:latest

ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

# ==============================================================================
# install deps
# ==============================================================================
RUN apt-get update \
  && apt-get install -y ruby gems g++ ruby-dev libcurl3 libcurl3-gnutls \
  libcurl4-openssl-dev imagemagick default-jre inkscape phantomjs \
  calibre texlive-full nodejs

# nodejs => node
RUN cd /usr/local/bin && ln -s /usr/bin/nodejs node

WORKDIR /root
# ==============================================================================
# install epubcheck
# ==============================================================================
RUN curl -LO \
  https://github.com/IDPF/epubcheck/releases/download/v4.0.1/epubcheck-4.0.1.zip \
  && unzip epubcheck-4.0.1.zip -d bin && rm epubcheck-4.0.1.zip

# ==============================================================================
# install kindlegen
# ==============================================================================
RUN curl -LO \
  http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz \
  && tar -zxvf kindlegen_linux_2.6_i386_v2_9.tar.gz \
  && rm kindlegen_linux_2.6_i386_v2_9.tar.gz \
  && cd /usr/local/bin \
  && ln -s ~/kindlegen_linux_2.6_i386_v2_9/kindlegen kindlegen

# ==============================================================================
# softcover gem
# ==============================================================================
RUN apt-get install -y libxslt-dev libxml2-dev build-essential zlib1g-dev
RUN gem install softcover --pre --no-ri --no-rdoc -v 1.4.3

# ==============================================================================
# Health check
# ==============================================================================
ENV PATH="$PATH:/root:/root/bin"
ENV QT_QPA_PLATFORM="offscreen"
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
