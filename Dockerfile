FROM ubuntu:16.04
ENV REFRESHED_AT 2016-04-07

RUN apt-get update -qq && apt-get install -y build-essential apt-utils curl python

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y nodejs

WORKDIR /haraka
ADD . /haraka
RUN npm install

CMD /haraka/node_modules/Haraka/bin/haraka -c /haraka/
