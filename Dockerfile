FROM ruby:2.5

ARG uid

RUN apt-get update -qq && \
    apt-get install -y build-essential

WORKDIR /app

RUN useradd -u $uid -Um jekyll && \
    chown -R jekyll:jekyll /app

USER jekyll
