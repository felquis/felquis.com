FROM ruby:2.2

RUN gem install jekyll
RUN gem install jekyll-paginate

RUN mkdir -p /app
WORKDIR /app

EXPOSE 4000

COPY . /app

VOLUME /app

RUN jekyll build

CMD ["jekyll", "serve"]
