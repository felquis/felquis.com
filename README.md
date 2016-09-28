## Blog

I use docker to build this project, so once docker is installed in your machine you need to clone this repository then run
```
docker build -t felquis.com .
```

And run this image
```
docker run -v $(pwd):/app -p 4000:4000 -d felquis.com serve
```

It should expose http://localhost:4000 for you
