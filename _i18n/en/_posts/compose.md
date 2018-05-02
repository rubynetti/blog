---
layout: post
title: Rails Compose blablavladndfskfkjd
categories: docker rails
author: Giacomo Bertoldi
---

```YAML
version: '3'
```
```YAML
version: '3'

services:
  web:
    build: .
```
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
```YAML
version: '3'

services:
  web:
    build: .
    command: rails s -b 0.0.0.0
    volumes:
      - .:/app
      - bundle_cache:/usr/local/bundle
    ports:
      - 3000:3000

volumes:
  bundle_cache:
```
```
$ docker-compose run --rm web bundle
Creating network "myawesomeapp_default" with the default driver
Creating volume "myawesomeapp_bundle_cache" with default driver
Fetching gem metadata from https://rubygems.org/.........
...
Bundled gems are installed into `/usr/local/bundle`
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
```YAML
version: '3'

services:
  web:
    build: .
    command: rails s -b 0.0.0.0
    stop_signal: SIGINT
    volumes:
      - .:/app
      - bundle_cache:/usr/local/bundle
    ports:
      - 3000:3000
    restart: on-failure

volumes:
 bundle_cache:
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
