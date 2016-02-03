FROM alpine
MAINTAINER Miquel Sabaté Solà

RUN apk add --update bash zsh util-linux && rm -rf /var/cache/apk/*
COPY g.sh t/test.sh t/expected.txt /
