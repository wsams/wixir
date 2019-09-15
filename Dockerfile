# https://hexdocs.pm/phoenix/installation.html
# https://hexdocs.pm/phoenix/up_and_running.html
# docker build -t wixir --pull .
# docker run -it --rm wixir:latest bash
FROM elixir:1.9

WORKDIR /

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get -y install wget vim curl zip unzip git build-essential nodejs
RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.4.10 --force
RUN apt-get clean
RUN mix phx.new app --no-ecto

WORKDIR /app

CMD ["mix" , "phx.server"]