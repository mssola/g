FROM opensuse:latest
MAINTAINER Miquel Sabaté Solà <mikisabate@gmail.com>

RUN mkdir /g
WORKDIR /g
ADD . /g

ENTRYPOINT ["bash", "t/tests.sh"]
