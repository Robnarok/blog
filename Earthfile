VERSION 0.6

build:
  FROM klakegg/hugo:latest
  WORKDIR /test
  COPY . .
  RUN hugo
  SAVE ARTIFACT /test/public public

run:
  FROM nginx:stable-alpine
  WORKDIR /usr/share/nginx/html
  COPY +build/public .
  SAVE IMAGE --push git.robnarok.de/robnarok/blog

build-draft:
  FROM klakegg/hugo:latest
  WORKDIR /test
  COPY . .
  RUN hugo -D
  SAVE ARTIFACT /test/public public

draft:
  FROM nginx:stable-alpine
  WORKDIR /usr/share/nginx/html
  COPY +build-draft/public .
  SAVE IMAGE --push git.robnarok.de/robnarok/blog:stage

full:
  BUILD +draft
  BUILD +run

