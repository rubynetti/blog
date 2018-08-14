---
layout: post
title: >-
  Reindirizzamento su Netlify con Jekyll - Configurazione e impostazioni da
  usare.
date: 2018-08-14T12:33:39.286Z
yoast_keyword: netlify
description: Come configurare il redirect sul dominio principale.
categories: rails
toc: false
author: Alessandro
---
## Singola pagina

Per reindirizzamenti con **Jekyll** su **Netlify** puoi usare semplicemente il file _netlify.toml_ e configurarlo in questo modo:

```toml
[[redirects]]
  from = "/indirizzo-poco-amico-di-google.html"
  to = "/articolo-ruby-rails.html"
```

La soluzione è semplice e funzionale.

## Dominio

Come si può impostare il reindirizzamento al nuovo dominio appena acquistato?

Il nostro nuovo e scintillante dominio [www.rubynetti.it](http://www.rubynetti.it) è stato acquistato e impostato correttamente sul pannell di gestione del DNS.
Ora il blog è visibile andando semplicemente su www.rubynetti.it al posto del vecchio e scomodo rubynetti.netlify.com.

Purtroppo Google ha nella sua pancia ancora il vecchio indirizzo e vedrebbe i contenuti di questi sito come duplicati penalizzandolo in partenza.
Come è possibile risolvere questo problema?

Personalmente ho trovato che la soluzione più agevole sia** impostare la proprietà con google webmaster** e poi specificare a google la proprietà (e di conseguenza il dominio) preferito.

Tale soluzione sembra aver scongiurato problemi di penalizzazione o simili.

Per configurare in modo corretto il redirect è sufficiente impostare il file di configurazione **netlify.toml**  nel seguente modo:

```toml
[[redirects]]
  from = "https://rubynetti.netlify.com/*"
  to = "https://www.rubynetti.it/:splat"
  status = 301
  force = true
```
