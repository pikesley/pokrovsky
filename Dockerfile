FROM ruby:2.4

ENV PROJECT pokrovsky
WORKDIR /opt/${PROJECT}

RUN apt-get -y update && \
    apt-get install -y qt5-default libqt5webkit5-dev

COPY ./Gemfile* /opt/${PROJECT}
RUN bundle install

COPY ./ /opt/${PROJECT}
