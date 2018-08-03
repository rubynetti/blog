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

## Impostare la *virtual memory* del *kernel* di Linux a 262144

Per poter installare **Elasticsearch** tramite **docker compose** bisogna impostare il [max_map_count](https://www.kernel.org/doc/Documentation/sysctl/vm.txt) in modo adeguato alle sue esigenze, portando il valore da 65530 a 262144.
Per poterlo fare è necessario eseguire nel terminale della macchina il seguente comando:

```bash
sudo sysctl -w vm.max_map_count=262144
```

**Attenzione**: è importante notare che il comando va eseguito **nella macchina che ospita i container** e non all'interno del container di elasticsearch.

# Impostazioni per Rails

## Configurazioni del model.

Per impostare correttamente l'uso di Elasticsearch con Rails è sufficiente inserire nel __model__ su cui si vuole fare ricerca il seguente codice:

```ruby
searchkick(language: 'italian', callbacks: :async)
```

Il primo parametro (_language_) indica la lingua che si vuole usare. Il valore predefinito è l'inglese.
Il secondo parametro (_callbacks_) indica la strategia che si vuole utilizzare per l'aggiornamento dei dati all'interno di **Elasticsearch** tramite **Rails**.
Il valore predefinito prevede una sincronia immediata tramite Rails che potrebbe rallentare l'esperienza dell'utente finale. Se si può impostare _async_ è sicuramente meglio perché potremmo evitare di far pesare la sincronizzazione dei dati all'utente.

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

## Fonti
  - [Stackoverflow - Quanta memoria dovrebbe usare vm?](https://stackoverflow.com/questions/11683850/how-much-memory-could-vm-use)
  - [Guida ufficiale di Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
  - [Stackoverflow - Ricerca sulle associazioni con Elasticsearch](https://stackoverflow.com/questions/31046428/rails-searchkick-elasticsearch-has-many-and-belongs-to-associations/31097297#31097297)
