####################
# Stage 1: builder #
####################

FROM bitwalker/alpine-elixir:1.7.2 as builder

RUN apk --no-cache --update upgrade

WORKDIR /app

COPY apps /app/apps
COPY config /app/config
COPY rel/config.exs /app/rel/config.exs
COPY rel/vm.args /app/rel/vm.args
COPY mix.exs /app/mix.exs
COPY mix.lock /app/mix.lock

ENV MIX_ENV prod

RUN mix do hex.info, deps.get, deps.compile, release --env prod && \
  mkdir /app/dist && \
  cp _build/prod/rel/quantum_swarm_umbrella/releases/$(ls -t _build/prod/rel/quantum_swarm_umbrella/releases/ | head -1)/quantum_swarm_umbrella.tar.gz /app/dist/

####################
# Stage 2: runtime #
####################

FROM alpine:3.8

RUN apk --no-cache --update upgrade && \
  apk --no-cache add bash openssl

WORKDIR /app

COPY --from=builder /app/dist/quantum_swarm_umbrella.tar.gz .
COPY rel/bin /app/bin
RUN cd /app && \
  tar zxf quantum_swarm_umbrella.tar.gz && \
  rm quantum_swarm_umbrella.tar.gz

ENV REPLACE_OS_VARS true
ENV PORT 80
EXPOSE 80

ENTRYPOINT ["/app/bin/entrypoint.sh"]
CMD ["/app/bin/quantum_swarm_umbrella", "foreground", "&", "wait"]
