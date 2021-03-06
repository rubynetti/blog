---
layout: post
title: Containerize a Rails app with Docker Compose
categories: docker rails
author: Giacomo Bertoldi
---

[Compose](https://docs.docker.com/compose/install/#install-compose)
is a tool designed to configure and run multiple containers.



#### Docker Compose

_Compose_ works by parsing directions in a _docker-compose.yml_ file.
As with the _Dockerfile_, the usual place to create it
is the root of the application to conteinerize.

##### Version

First line  which version of the _Compose file format_
is us.
All directives in this example are intended to work with version _3_.
```YAML
version: '3'
```


#### Services

Every key inside the **services** one will spawn a different container,
composing our application.
In this case we just need a **web** service.
```YAML
version: '3'

services:
  web:
```


#### Build
The **build** key tells _Compose_ where to find the _Dockerfile_,
```.``` loads it from the current directory

```YAML
version: '3'

services:
  web:
    build: .
```

We can now ```docker-compose build``` to create the image.
```
$ docker-compose build
Building web
Step 1/5 : FROM ruby:2.5
...
Step 2/5 : RUN apt-get update -qq &&     apt-get install -y build-essential nodejs
...
Step 3/5 : WORKDIR /app
...
Step 4/5 : RUN useradd -u 1000 -Um rails &&     chown -R rails:rails /app
...
Step 5/5 : USER rails
...
Successfully built {image-id}
Successfully tagged myawesomeapp_web:latest
```
Notice the image is conviniently named using the app directory name followed by the name of the service.


#### Bundle

Before starting the rails app we should bundle, we can do that inside a temporary container

```YAML
version: '3'

services:
  web:
    build: .
    volumes:
      - .:/app
      - app_bundle:/usr/local/bundle

volumes:
  app_bundle:
```

To bundle inside a temporary container

```
$ docker-compose run --rm web bundle
Creating network "myawesomeapp_default" with the default driver
Creating volume "app_myawesomeapp_bundle" with default driver
Fetching gem metadata from https://rubygems.org/.........
...
Bundled gems are installed into `/usr/local/bundle`
```


##### Up

```YAML
version: '3'

services:
  web:
    build: .
    command: rails s -b 0.0.0.0
    volumes:
      - .:/app
      - app_bundle:/usr/local/bundle
    ports:
      - 3000:3000

volumes:
  app_bundle:
```

```
$ docker-compose up
Creating myawesomeapp_web_1 ... done
Attaching to myawesomeapp_web_1
web_1  | => Booting Puma
web_1  | => Rails 5.2.0 application starting in development
web_1  | => Run `rails server -h` for more startup options
web_1  | Puma starting in single mode...
web_1  | * Version 3.11.4 (ruby 2.5.0-p0), codename: Love Song
web_1  | * Min threads: 5, max threads: 5
web_1  | * Environment: development
web_1  | * Listening on tcp://0.0.0.0:3000
web_1  | Use Ctrl-C to stop
```


#### Final touches

```YAML
version: '3'

services:
  web:
    build: .
    command: rails s -b 0.0.0.0
    stop_signal: SIGINT
    volumes:
      - .:/app
      - app_bundle:/usr/local/bundle
    ports:
      - 3000:3000
    restart: on-failure

volumes:
 app_bundle:
```

```
$ docker-compose start
Starting web ... done
```
```
sudo docker-compose exec web bash
rails@container-id:/app$
```
```
rails@container-id:/app$ rails g migration create_users name:string surname:string
Running via Spring preloader in process 70
      invoke  active_record
      create    db/migrate/timestamp_create_users.rb
rails@container-id:/app$ rails db:migrate
== 20180502151325 CreateUsers: migrating ======================================
-- create_table(:users)
   -> 0.0024s
== 20180502151325 CreateUsers: migrated (0.0026s) =============================
```
restart stop down down -v
