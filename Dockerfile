FROM ruby:2.1
MAINTAINER graham@grahamc.com

RUN apt-get update \
  && apt-get install -y \
    node \
    python-pygments \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

RUN gem install \
  github-pages \
  jekyll \
  jekyll-redirect-from \
  kramdown \
  rdiscount \
  rouge \
  jekyll-paginate

VOLUME /src
WORKDIR /src
COPY . /src
ENTRYPOINT ["jekyll"]
