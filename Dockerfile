FROM ruby:2.2

RUN gem install jekyll
RUN gem install jekyll-paginate

RUN mkdir -p /app
WORKDIR /app

COPY . /app

VOLUME /app

EXPOSE 4000:4000

RUN jekyll build

CMD ["jekyll", "serve"]
