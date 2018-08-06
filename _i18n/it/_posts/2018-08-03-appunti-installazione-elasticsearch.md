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

<<<<<<< HEAD
```yaml
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
```
=======
<script src="https://gist.github.com/simonini/9a5c9d3ec040ce2d412562333792324c.js"></script>
>>>>>>> d1149abf4539bf665bb3692e6ed3952c3aedfbe4

## Impostare la _virtual memory_ del _kernel_ di Linux a 262144

Per poter installare **Elasticsearch** tramite **docker compose** bisogna impostare il [max_map_count](https://www.kernel.org/doc/Documentation/sysctl/vm.txt) in modo adeguato alle sue esigenze, portando il valore da 65530 a 262144.
Per poterlo fare è necessario eseguire nel terminale della macchina il seguente comando:

<<<<<<< HEAD
```bash
sudo sysctl -w vm.max_map_count=262144
```

**Attenzione**: è importante notare che il comando va eseguito **nella macchina che ospita i container** e non all'interno del container di elasticsearch.
=======
```
sudo sysctl -w vm.max_map_count=262144
```
>>>>>>> d1149abf4539bf665bb3692e6ed3952c3aedfbe4

# Impostazioni per Rails

Dopo aver installato normalmente la gemma _searchkick_ bisogna configurare i model.

## Configurazioni del model.

Per impostarne correttamente l'uso con Rails è sufficiente inserire nel **model** su cui si vuole fare ricerca il seguente codice:

```ruby
searchkick(language: 'italian', callbacks: :async)
```

Il primo parametro (_language_) indica la lingua che si vuole usare.
Il valore predefinito è l'inglese.
Se stai leggendo questo articolo probabilmente sei interessato a impostare il settaggio in italiano.

Il secondo parametro (_callbacks_) indica la strategia che si vuole utilizzare per l'aggiornamento dei dati.
Il valore predefinito prevede una sincronia immediata tramite Rails.
L'impostazione predefinita potrebbe quindi rallentare l'esperienza dell'utente finale.
In sintesi, quando è possibile, è meglio impostare _async_.

## Indicizzazione degli elementi

Per poter effettuare le ricerche sul model bisogna indicizzarlo.
Per poterlo fare è sufficiente usare il metodo _reindex_.
Ad esempio, una volta entrato nella console di *Rails* è sufficiente scrivere:

```ruby
Book.reindex
```

## Come posso cercare anche sui model associati?

Per poter cercare anche sui model associati si usa il metodo __search_data__ aggiungendo agli attributi i valori che si vogliono aggiungere nella ricerca.
Per esempio in un model Book per cercare anche sui model esterni autori (_author_), soggetti (_subjects_) ed editore dei libri (_publisher_) si può impostare il model nel seguente modo:

```ruby
# model/book.rb
def search_data
  attributes.merge(author_name: author(&:name)
                publisher_name: publisher(&:name)
                 subjects_name: subjects.map(&:name))
end
```

## Come posso cercare?

Per poter cercare attraverso il model basta usare il metodo di istanza **search** sul model. Ad esempio:

```ruby
Book.search("titolo del libro")
```

## Fonti
  - [Stackoverflow - Quanta memoria dovrebbe usare vm?](https://stackoverflow.com/questions/11683850/how-much-memory-could-vm-use)
  - [Guida ufficiale di Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
  - [Stackoverflow - Ricerca sulle associazioni con Elasticsearch](https://stackoverflow.com/questions/31046428/rails-searchkick-elasticsearch-has-many-and-belongs-to-associations/31097297#31097297)
