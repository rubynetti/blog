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
    volumes:
      - 'redis_data:/data'
volumes:
  [..]
  redis_data:
```

Questa soluzione permette di installare tramite docker-compose una istanza funzionante e operativa di redis.
