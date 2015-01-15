FROM phusion/baseimage:0.9.15

MAINTAINER Luis Silva <luis@arcturus.io>

RUN echo /root > /etc/container_environment/HOME

CMD ["/sbin/my_init"]

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /tmp

# See : https://github.com/phusion/baseimage-docker/issues/58
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Update repos
RUN echo "deb http://packages.erlang-solutions.com/ubuntu trusty contrib" >> /etc/apt/sources.list && \
    apt-key adv --fetch-keys http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc && \
    apt-get -qq update && apt-get install -y \
    erlang=1:17.4 \
    git \
    unzip \
    build-essential \
    wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
# Download and Install Specific Version of Elixir
WORKDIR /elixir
RUN wget -q https://github.com/elixir-lang/elixir/releases/download/v1.0.2/Precompiled.zip && \
    unzip Precompiled.zip && \
    rm -f Precompiled.zip && \
    ln -s /elixir/bin/elixirc /usr/local/bin/elixirc && \
    ln -s /elixir/bin/elixir /usr/local/bin/elixir && \
    ln -s /elixir/bin/mix /usr/local/bin/mix && \
    ln -s /elixir/bin/iex /usr/local/bin/iex
    
# Install local Elixir hex and rebar
RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force
    
# Add the SSH keys from github
ADD id_rsa_arcturus /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Download and install Isis project    
RUN cd / && git clone git@github.com:arcturusbiocloud/isis.git
# Trick run the following instructions everytime
ADD http://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new uuid
# Set Isis directory as the start directory
WORKDIR /isis
RUN git pull
RUN MIX_ENV=prod mix do deps.get
RUN MIX_ENV=prod mix do deps.compile
RUN MIX_ENV=prod mix compile
RUN MIX_ENV=prod mix compile.protocols

# HTTP port
EXPOSE 4000
# EPMD and node communication ports
EXPOSE 4369
EXPOSE 9100
EXPOSE 9101
EXPOSE 9102
EXPOSE 9103
EXPOSE 9104
EXPOSE 9105