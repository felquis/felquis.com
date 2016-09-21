# FROM jekyll/jekyll:pages

# RUN gem install jekyll
# RUN gem install jekyll-paginate

# RUN mkdir -p /srv/jekyll
# WORKDIR /srv/jekyll

# EXPOSE 4000

# COPY . /srv/jekyll
# VOLUME /srv/jekyll

# https://github.com/grahamc/docker-jekyll

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
  rouge

VOLUME /src
EXPOSE 4000

WORKDIR /src
ENTRYPOINT ["jekyll"]

