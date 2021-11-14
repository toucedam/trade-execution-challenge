FROM ruby:2.5
RUN apt-get update -qq

WORKDIR /test

COPY Gemfile /test/Gemfile
COPY Gemfile.lock /test/Gemfile.lock

RUN bundle install
COPY src/ test/src
COPY spec/ test/spec

RUN bundle exec rspec test/spec/ -f d