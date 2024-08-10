FROM alpine:3.19 as build
RUN apk add crystal shards
RUN apk add openssl-dev yaml-dev zlib-dev \
  # Static build dependencies
  openssl-libs-static yaml-static zlib-static

WORKDIR /app
COPY shard.lock .
COPY shard.yml .
RUN shards install --production
COPY . .

RUN shards build demo-crystal-kemal --static

FROM alpine:3.19
# Install curl for Kamal health checks
RUN apk add curl
WORKDIR /
COPY --from=build /app/bin/demo-crystal-kemal .
EXPOSE 3000
CMD ["/demo-crystal-kemal"]
