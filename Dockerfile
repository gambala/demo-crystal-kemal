FROM alpine:3.19 as build
  RUN apk add crystal shards \
              openssl-dev yaml-dev zlib-dev \
              openssl-libs-static yaml-static zlib-static # Static build dependencies
  WORKDIR /app
  COPY shard.yml shard.lock /app/
  RUN shards install --production
  COPY . .
  RUN shards build demo-crystal-kemal --static


FROM alpine:3.19
  WORKDIR /
  COPY --from=build /app/bin/demo-crystal-kemal .
  EXPOSE 3000
  CMD ["/demo-crystal-kemal"]
