FROM node:16-alpine as node
FROM nginx:1.20-alpine
LABEL maintainer="ucan-lab <yes@u-can.pro>"
SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

ENV TZ=UTC

RUN apk update && \
  apk add --update --no-cache --repository http://nl.alpinelinux.org/alpine/edge/main libstdc++
  # apk add --update --no-cache --virtual=.build-dependencies g++
  # https://zenn.dev/n04h/scraps/74063e99cdb7f4

# node command
COPY --from=node /usr/local/bin /usr/local/bin
# npm command
COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
COPY --from=node /opt /opt
# nginx config file
COPY ./infra/docker/nginx/*.conf /etc/nginx/conf.d/

# アプリケーションコードをコピー
# nginx のイメージに必要なのは backend ディレクトリ全体ではなく、
# backend/public ディレクトリなので、それのみコピー
COPY ./backend/public /work/backend/public

WORKDIR /work/backend
