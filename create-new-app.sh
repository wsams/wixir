#!/bin/bash

# Usage: ./create-new-app.sh [wixir image tag optional - defaults to latest]
# A directory ./app will be created. You can then start the application with:
# docker-compose up -d app

echo && echo -e "You will be prompted to overwrite /app. You will also be prompted to fetch and install dependencies.\n\nIf this is the first time running this script you must answer yes.\n\nFrom then on out you should not run this script or risk overwriting your work." && echo

docker run -it --rm -v $(pwd)/app:/app wsams/wixir:${1:-latest} bash -c \
    'mix phx.new /app --no-ecto && mix deps.get && cd assets && npm install'

