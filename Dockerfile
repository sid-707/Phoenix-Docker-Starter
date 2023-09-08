FROM elixir:1.15.4

RUN apt-get update && \
    apt-get -y install inotify-tools postgresql-client

RUN mkdir /app
WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install hex phx_new

CMD ["bash", "-c", "/app/entrypoint.sh"]