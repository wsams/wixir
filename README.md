# wixir

Elixir Phoenix Docker image and Docker Compose project builder.

Image found on Docker Hub at https://hub.docker.com/r/wsams/wixir

GitHub project found at https://github.com/wsams/wixir

# Read first

Note, both quick start guides (with and without a database) create an application in your git clone. Ideally you would create a directory somewhere else on your filesystem and copy all scripts (`.sh` files) and `docker-compose.yml` there before performing any of the actions. This is not necessary if you want to see how this project works, but for a real project it is recommended.

This project was developed on both MacOS and Linux and assumes you have BASH, `docker`, and `docker-compose` installed, and Docker running on your system. You should still be able to use Docker for Windows, but you will have to manually run the docker commands found in the shell scripts.

# Quick Start (no database) (without ecto)

```
git clone git@github.com:wsams/wixir.git
cd wixir
./create-new-app.sh
docker-compose up -d app
```

It will take a couple minutes for assets to compile. Once finished you will find your application at,

http://localhost:4000/

# Quick Start (with a PostgreSQL database) (with ecto)

The `create-new-db-app.sh` script starts a PostgreSQL container and configures your application to use this container. The script will prompt for details and explain what's going to happen and will give you the option to quit.

```
git clone git@github.com:wsams/wixir.git
cd wixir
./create-new-db-app.sh
docker-compose up -d app
```

It will take a couple minutes for assets to compile. Once finished you will find your application at,

http://localhost:4000/

See https://hexdocs.pm/phoenix/ecto.html for information on creating schemas and working with Ecto.

## Create new schemas and run migrations

The `create-new-schema.sh` script will create a `.ex` file in `lib/app` with your schema definitions and a migration file in `priv/repo/migrations`. For example let's create a `Cat` schema. Note, an `id` field will be created automatically, no need to pass one. Run the script without arguments for help.

```
./create-new-schema.sh Cat cats 'name:string age:integer'
```

Once that's created you can use the `run-migrations.sh` script to create your schema in the real database. You can build up all of your schemas first or run it each time.

```
./run-migrations.sh
```

# Developing an Application

Once your application is running you may edit files and Webpack will compile them in real-time. For example, to change the default index page edit,

```
/app/lib/app_web/templates/page/index.html.eex
```

Refresh the index page and you should see your content changed without restarting the server.

