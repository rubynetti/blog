---
layout: post
title: 'Vue.js: i primi appunti di questa libreria javascript.'
date: '2018-04-17 17:02:22 +0200'
yoast_keyword: vue
description: Appunti su vue.js in una interazione col mio progetto di Rails.
---
# Approcci con Vue.js

Nella board di [momento.cc](momento.cc) ho bisogno di aggiungere elementi interattivi e dinamici avanzati. Per questo motivo ho deciso di sperimentare con **Vue.js**.

Tra i problemi che ho incontrato nel primo approccio:

* aver pensato in modo strettamente react-like
* una solo parziale chiarezza su quale sia il significato della direttiva v-model
* tag select e ottenere i nomi dai progetti
* la copia di un oggetto in javascript

## Aver pensato in modo react-like

Pensare i componenti di Vue allo stesso modo dei componenti React è un errore.
Infatti questa libreria non ama i componenti molto piccoli o annidati.
Per il rapporto tra eventi e componenti è meglio tenere "vicino" il componente che scatena l'evento e l'evento che ne subisce le conseguenze.
Nel mio caso iniziale basta una struttura semplice.

## Scarsa chiarezza sulla direttiva v-model

La direttiva **v-model** è sintassi zuccherata per l'aggiornamento dei dati sulla base dell'input dell'utente.

## Tag select

Ho una certa difficoltà ad estrarre i dati dei progetti sulla base del tag select.

Dopo una lunga elaborazione sono arrivato a questa soluzione:

<script src="https://gist.github.com/simonini/956552ed9b5f3a75daf6f31472e88a9f.js"></script>

A posteriori la soluzione è _ovvia_ e _leggibile_.

Con questa soluzione quando l'utente seleziona una delle voci all'interno del **menu a tendina** cambia i valori _data_ dal componente Vue.

## Copia di un oggetto in Javascript

Quando veniva aggiunto una voce alla lista, la voce rimaneva ancorata al form.
Per slegare le due fasi ho dovuto inserire il seguente codice:

```
let copy = {...new_momento}
this.momentos_list.push(copy)
```

La clonazione dell'oggetto avviene tramite nuove funzionalità fornite da javascript in edizione ES6.
La clonazione serve a impedire il passaggio per referenza.

### Fonti:

* [Vue Guida Ufficiale - Form](https://vuejs.org/v2/guide/forms.html)
* [Vue Guida Ufficiale - Form - Select](https://vuejs.org/v2/guide/forms.html#Select)
* [Vue Tutorial su Laracasts](https://laracasts.com/series/learn-vue-2-step-by-step/episodes/12)
