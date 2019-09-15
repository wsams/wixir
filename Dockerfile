# https://hexdocs.pm/phoenix/installation.html
# https://hexdocs.pm/phoenix/up_and_running.html
# docker build -t wixir --pull .
# docker run -it --rm wixir:latest bash
FROM elixir:1.9

WORKDIR /

RUN apt-get update && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get -y install wget vim curl zip unzip git build-essential nodejs && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.4.10 --force && \
    apt-get clean && \
    mix phx.new app --no-ecto && \
    cd app && \
    mix deps.get && \
    mix local.rebar --force && \
    cd assets && \
    npm install

WORKDIR /app

CMD ["mix" , "phx.server"]
