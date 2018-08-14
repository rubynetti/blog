---
layout: post
title: 'Redis: configurazione con Docker e Rails'
date: 2018-08-13T13:50:39.286Z
yoast_keyword: redis
description: Redis i passaggi per una veloce configurazione con docker compose.
---

Per poter usare correttamente Rails e Redis insieme a Docker è necessario configurare il docker-compose nel seguente modo:

```yaml
version: '3'

services:
  web:
    [..]
  db:
    [..]
  redis:
    image: 'redis:4.0-alpine'
    command: redis-server
    ports:
      - 6379:6379
    volumes:
      - 'redis_data:/data'
volumes:
  [..]
  redis_data:
```

Questa soluzione permette di installare tramite docker-compose una istanza funzionante e operativa di redis.

Bisogna poi comunicare a Rails come raggiungere il nostro server redis poichè Docker non è solito usare il nostro network in modo convenzionale.

Per poterlo fare è necessario usare i nomi che abbiamo dato ai servizi.

Quindi all'interno di _config/initializer/redis.rb_ vanno aggiunte le seguenti istruzioni.

```ruby
if Rails.env.development?
  REDIS_CLIENT = Redis.new(host: 'redis', port: 6379, db: 1)
else
  REDIS_CLIENT = Redis.new(host: 'localhost', port: 6379, db: 1)
end
```

Ovviamente questa è una configurazione che __non__ prevede l'utilizzo di redis con docker all'interno della produzione ma solo in ambiente di sviluppo.
