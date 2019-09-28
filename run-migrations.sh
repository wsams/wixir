#!/bin/bash

docker-compose run --rm -v $(pwd)/app:/app app bash \
    -c "mix ecto.migrate"

