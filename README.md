# wixir

Elixir Phoenix Docker image and Docker Compose sample project.

Image found on Docker Hub at https://hub.docker.com/r/wsams/wixir

GitHub project found at https://github.com/wsams/wixir

# Quick Start

```
git clone git@github.com:wsams/wixir.git
cd wixir
./create-new-app.sh
docker-compose up -d
```

It will take a couple minutes for assets to compile. Once finished you will find your application at,

http://localhost:4000/

# Developing an Application

Once your application is running you may edit files and Webpack will compile them in real-time. For example, to change the default index page edit,

```
/app/lib/app_web/templates/page/index.html.eex
```

Refresh the index page and you should see your content changed without restarting the server.
