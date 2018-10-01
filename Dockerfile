FROM ruby:2.5

RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev

COPY Gemfile* /tmp/
WORKDIR /tmp/
RUN bundle install

ENV app /app
RUN mkdir $app
WORKDIR $app
