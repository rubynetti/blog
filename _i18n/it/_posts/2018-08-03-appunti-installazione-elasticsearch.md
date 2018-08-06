---
layout: post
title: 'Elasticsearch, Docker e Rails, installazione e primi passi.'
date: '2018-08-02 17:02:22 +0200'
yoast_keyword: elasticsearch
description: >-
  Come usare elasticsearch con Rails e docker? Ecco degli appunti presi durante
  lo sviluppo di una applicazione reale.
categories: docker elasticsearch rails
toc: true
---
# Installazione di Elasticsearch

## Come installarlo con Docker?

Per usare elasticsearch impostare il proprio docker-compose.yml in questo modo:

<script src="https://gist.github.com/simonini/9a5c9d3ec040ce2d412562333792324c.js"></script>

## Impostare la _virtual memory_ del _kernel_ di Linux a 262144

Per poter installare **Elasticsearch** tramite **docker compose** bisogna impostare il [max_map_count](https://www.kernel.org/doc/Documentation/sysctl/vm.txt) in modo adeguato alle sue esigenze, portando il valore da 65530 a 262144.

```
sudo sysctl -w vm.max_map_count=262144
```

# Impostazioni per Rails

## Configurazioni del model.

Per impostarne correttamente l'uso con Rails è sufficiente inserire nel **model** su cui si vuole fare ricerca il seguente codice:

```
searchkick(language: 'italian', callbacks: :async)
```

Il primo parametro (_language_) indica la lingua che si vuole usare. 
Il valore predefinito è l'inglese.
Se stai leggendo questo articolo probabilmente sei interessato a impostare il settaggio in italiano.

Il secondo parametro (_callbacks_) indica la strategia che si vuole utilizzare per l'aggiornamento dei dati.
Il valore predefinito prevede una sincronia immediata tramite Rails.
L'impostazione predefinita potrebbe quindi rallentare l'esperienza dell'utente finale. 
In sintesi, quando è possibile, è meglio impostare _async_.

## Fonti

* [Stackoverflow](https://stackoverflow.com/questions/11683850/how-much-memory-could-vm-use)
* [Guide from elastic.co](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
