---
layout: post
title:  Elasticsearch, Docker e Rails, installazione e primi passi.
date:   2018-08-02 17:02:22 +0200
categories: docker elasticsearch rails
toc: true
---

# Installazione di Elasticsearch

## Come installare elasticsearch con Docker?

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

Per poter installare **Elasticsearch** tramite **docker compose** bisogna impostare il [max_map_count](https://www.kernel.org/doc/Documentation/sysctl/vm.txt) in modo adeguato alle sue esigenze, portando il valore da 65530 a 262144.

    sudo sysctl -w vm.max_map_count=262144


# Impostazioni per Rails

## Configurazioni del model.

Per impostare correttamente l'uso di Elasticsearch con Rails è sufficiente inserire nel __model__ su cui si vuole fare ricerca il seguente codice:

    searchkick(language: 'italian', callbacks: :async)

Il primo parametro (_language_) indica la lingua che si vuole usare. Il valore predefinito è l'inglese.
Il secondo parametro (_callbacks_) indica la strategia che si vuole utilizzare per l'aggiornamento dei dati all'interno di **Elasticsearch** tramite **Rails**.
Il valore predefinito prevede una sincronia immediata tramite Rails che potrebbe rallentare l'esperienza dell'utente finale. Se si può impostare _async_ è sicuramente meglio perché potremmo evitare di far pesare la sincronizzazione dei dati all'utente.


## Fonti
  - [Stackoverflow](https://stackoverflow.com/questions/11683850/how-much-memory-could-vm-use)
  - [Guide from elastic.co](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
