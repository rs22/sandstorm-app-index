FROM alpine:3.16

RUN apk add --no-cache make jq curl ca-certificates

WORKDIR /app

COPY Makefile .
COPY Apps.make .
COPY cronjobs /etc/crontabs/root

# start crond with log level 8 in foreground, output to stderr
CMD ["crond", "-f", "-d", "8"]
