---
layout: post
title:  Elasticsearch e Docker, installazione.
date:   2018-08-02 17:02:22 +0200
categories: docker elasticsearch
toc: true
---

# Come installare elasticsearch con Docker?

Impostare il proprio docker-compose.yml in questo modo:

    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch:6.3.2
      container_name: elasticsearch
      volumes:
        - esdata1:/usr/share/elasticsearch/data
      ports:
        - 9200:9200
    volumes:
      esdata1:
        driver: local

## Impostare la *virtual memory* del *kernel* di Linux a 262144

Per poter installare **Elasticsearch** tramite *docker-compose* bisogna impostare il [max_map_count](https://www.kernel.org/doc/Documentation/sysctl/vm.txt) in modo adeguato alle sue esigenze, portando il valore da 65530 a 262144.

    sudo sysctl -w vm.max_map_count=262144
