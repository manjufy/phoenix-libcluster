FROM debian:8.4

EXPOSE 8080

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y upgrade && \
    apt-get install --no-install-recommends -y \
    git \
    curl \
    wget \
    nano \
    unzip \
    ca-certificates && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
	dpkg -i erlang-solutions_1.0_all.deb && \
 	apt-get update && \
 	DEBIAN_FRONTEND=noninteractive apt-get install -y elixir=1.4.1-1 erlang-dev erlang-parsetools
RUN apt-get install -y libssl-dev

ENV LANG C.UTF-8

RUN mix local.hex --force && \
	mix local.rebar --force && \
	apt-get autoclean

RUN mkdir /app
COPY . /app

WORKDIR /app
RUN mix deps.get
RUN date | md5sum | tr -d '\n' > .nomnom
#CMD PORT=8080 mix phoenix.server
