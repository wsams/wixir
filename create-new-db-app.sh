#!/bin/bash

# Usage: ./create-new-db-app.sh [wixir image tag optional - defaults to latest]
# A directory ./app will be created. You can then start the application with:
# docker-compose up -d app

echo
echo "You will be prompted to overwrite /app. You will also be prompted to fetch and install dependencies."
echo
echo "If this is the first time running this script you must answer yes."
echo "From then on out you should not run this script or risk overwriting your work."
echo
echo "This script will also set up your database."
echo "You'll be asked for your: database, username, and password."
echo "A .env file will be created or overwritten in the current directory,"
echo "a postgres container started, and your ecto 'app/config/dev.exs'"
echo "configured and 'mix ecto.create' executed."
echo "You will then be ready to start your application with docker-compose."
echo -n "Are you ready? (Enter 'yes', or anything else to quit) "
read ready
echo

if [ $ready != "yes" ]; then
    echo "You must answer 'yes' to create a new application."
    exit
fi

#docker run -it --rm -v $(pwd)/app:/app wsams/wixir:${1:-latest} bash -c \
#    'mix phx.new /app && mix deps.get && cd assets && npm install'

echo "Ready to set up your database."
echo -n "Enter your database name: "
read dbname
echo
echo -n "Enter your database username: "
read dbusername
echo
echo -n "Enter your database password: "
read dbpassword

sed -i '' -e "s/username: \"postgres\"/username: \"${dbusername}\"/" \
          -e "s/password: \"postgres\"/password: \"${dbpassword}\"/" \
          -e "s/database: \"app_dev\"/database: \"${dbname}\"/" \
          -e "s/hostname: \"localhost\"/hostname: \"db\"/" \
          -e "s/show_sensitive_data_on_connection_error: true/show_sensitive_data_on_connection_error: false/" \
    app/config/dev.exs

echo "POSTGRES_DB=${dbname}
POSTGRES_USER=${dbusername}
POSTGRES_PASSWORD=${dbpassword}
" > .env

docker-compose up -d db

echo -n "Waiting for PostgreSQL to start up"
until docker-compose logs | grep 'PostgreSQL init process complete; ready for start up.' 2>/dev/null; do
    echo -n "."
    sleep 2
done

until docker-compose logs | grep 'database system is ready to accept connections' 2>/dev/null; do
    echo -n "."
    sleep 2
done

echo
echo "Done, your application is ready to be started."
echo "Run: docker-compose up -d app"
echo

# Sample command for creating your database if not using the `db` service. For
# example with an external database. This assumes you manually configured `app/config/dev.exs`
#docker-compose run --rm -v $(pwd)/app:/app app bash -c 'mix ecto.create /app'

