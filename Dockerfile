#
# Dockerfile for xray
#

FROM teddysun/xray as source

FROM alpine
COPY --from=source /usr/bin/xray /usr/local/bin/xray
COPY --from=source /usr/share/xray /usr/local/share/xray

COPY config.init /etc/xray/config.init
COPY docker-entrypoint.sh /entrypoint.sh

RUN set -ex \
  && apk add --update --no-cache \
     ca-certificates \
     openssl \
  && mkdir -p /var/log/xray \
  && rm -rf /tmp/* /var/cache/apk/*

ENV PORT 8080
ENV SERVICE=

WORKDIR /etc/xray

ENTRYPOINT ["/entrypoint.sh"]
CMD ["xray","run","-c","config.json"]
