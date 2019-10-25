FROM alpine/git

RUN apk add --no-cache bash findutils

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]