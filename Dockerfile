FROM ruby:2.3.8

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app
