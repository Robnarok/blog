VERSION 0.6

build:
  FROM klakegg/hugo:latest
  WORKDIR /test
  COPY . .
  RUN hugo -D
  SAVE ARTIFACT /test/public public

run:
  FROM caddy:alpine
  WORKDIR /usr/share/caddy
  COPY +build/public .
  RUN ls
  RUN cat index.html
  SAVE IMAGE blog:latest
