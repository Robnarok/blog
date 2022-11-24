FROM klakegg/hugo:latest AS build
WORKDIR /test
COPY . .
RUN hugo

FROM caddy:latest
RUN rm -rf /usr/share/caddy/
COPY --from=build /test/public /usr/share/caddy/.
RUN ls /usr/share/caddy/.
