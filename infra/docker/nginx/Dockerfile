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
# nginx config file will be output to /etc/nginx/conf.d/ by envsubst
# コンテナ起動時に環境変数 VPC_CIDR が渡されていれば、default.conf の「$VPC_CIDR」の部分には、環境変数の値が展開され る
COPY ./infra/docker/nginx/default.conf /etc/nginx/templates/default.conf.template
COPY ./infra/docker/nginx/nginx.conf /etc/nginx/nginx.conf

# アプリケーションコードをコピー
# nginx のイメージに必要なのは backend ディレクトリ全体ではなく、
# backend/public ディレクトリなので、それのみコピー
COPY ./backend/public /work/backend/public

WORKDIR /work/backend
