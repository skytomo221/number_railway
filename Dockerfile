FROM ruby

COPY . /workspace
WORKDIR /workspace

RUN bundle install

RUN apt-get update && apt-get install -y \
    graphviz

RUN gem install ruby-graphviz
