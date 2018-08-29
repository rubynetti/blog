---
layout: post
title: >-
  Vue.js: 4 problemi incontrati durante la mia prima volta all'interno di una
  applicazione Rails.
date: '2018-04-17 17:02:22 +0200'
yoast_keyword: vue
description: >-
  Appunti su vue.js in una interazione col mio progetto di Rails. L'elenco dei
  problemi che ho incontrato con questa nuova libreria javascript.
categories: 'javascript, vue'
toc: true
author: Alessandro Descovi
---
# Approcci con Vue.js

Nella board di [momento.cc](http://momento.cc) (una applicazione *Rails*) ho bisogno di aggiungere elementi interattivi e dinamici avanzati. Per questo motivo ho deciso di fare delle sperimentazione con la libreria javascript **Vue.js**.

Tra i problemi che ho incontrato nel mio primo approccio ho incontrato i seguenti problemi:

1. aver pensato in modo aderente alla filosofia di React
2. una solo parziale chiarezza su quale sia il significato della direttiva v-model
3. tag select e ottenere i nomi dai progetti
4. la necessità di creare una copia di un oggetto in javascript

## 1. Aver pensato in modo aderente alla filosofia di React

Pensare i componenti di Vue allo stesso modo dei componenti React è un errore.
Questa libreria Javascript, diversamente da React, non ama i componenti piccoli o annidati.
Per il rapporto tra eventi e componenti è meglio tenere "vicino" il componente che scatena l'evento e l'evento che ne subisce le conseguenze.
Nel mio caso iniziale basta una struttura semplice.

## 2. Scarsa chiarezza sulla direttiva v-model

La direttiva **v-model** è sintassi zuccherata per l'aggiornamento dei dati sulla base dell'input dell'utente.

## 3. Il tag \<select\>

Ho una certa difficoltà ad estrarre i dati dei progetti sulla base del tag select.

Dopo una lunga elaborazione sono arrivato a questa soluzione:

<script src="https://gist.github.com/simonini/956552ed9b5f3a75daf6f31472e88a9f.js"></script>

A posteriori la soluzione è _ovvia_ e _leggibile_.

Con questa soluzione l'utente, quando seleziona una delle voci all'interno del **menu a tendina**, cambia i valori _data_ dal componente Vue.

## 4. La necessità di creare una copia di un oggetto in javascript

Quando veniva aggiunto una voce alla lista, la voce rimaneva ancorata al form.
Per slegare le due fasi ho dovuto inserire il seguente codice:

```
let copy = {...new_momento}
this.momentos_list.push(copy)
```
Vi sono, all'interno di questa porzione di javascript, delle cose che mi sono particolarmente oscure e poco chiare.
La clonazione dell'oggetto avviene tramite nuove funzionalità fornite da javascript in edizione ES6.
La mia conoscenza del javascript moderno ha grosse lacune.
Questa è stata sicuramente una occasione per imparare il modo di copiare un oggetto impedendo a impedire il passaggio per referenza.

### Fonti:

* [Guida Ufficiale - Form](https://vuejs.org/v2/guide/forms.html)
* [Guida Ufficiale - Form - Select](https://vuejs.org/v2/guide/forms.html#Select)
* [Vue Tutorial su Laracasts](https://laracasts.com/series/learn-vue-2-step-by-step/episodes/12)
