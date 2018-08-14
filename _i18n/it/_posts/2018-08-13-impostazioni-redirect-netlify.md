---
layout: post
title: Reindirizzamento su Netlify con Jekyll
date: 2018-08-14T14:50:39.286Z
yoast_keyword: netlify
categories: rails
author: Alessandro
---

#

## Singola pagina

Per reindirizzamenti / redirect con jekyll su netlify puoi usare semplicemente il file _netlify.toml_ e configurarlo in questo modo:

```toml
[[redirects]]
  from = "/indirizzo-poco-amico-di-google.html"
  to = "/articolo-ruby-rails.html"
```

La soluzione è semplice e funzionale.

## Dominio

Come si può impostare il reindirizzamento con Netlify al nuovo dominio appena acquistato?

Il nostro nuovo e scintillante dominio rubynetti.it è stato acquistato e impostato correttamente su Netsons.
Ora il blog è visibile andando semplicemente su www.rubynetti.it al posto del vecchio e scomodo rubynetti.netlify.com.

Purtroppo google ha nella sua pancia ancora il vecchio indirizzo e vedrebbe i contenuti di questi sito come duplicati penalizzandolo in partenza.
Come è possibile risolvere questo problema?

Personalmente ho trovato che la soluzione più agevole sia impostare la proprietà con google webmaster e poi specificare a google la proprietà (e di conseguenza il dominio) preferito.

Tale soluzione sembra aver scongiurato problemi di penalizzazione o simili.

Per configurare in modo corretto netlify al fine di fare reindirizzamenti in modo corretto è sufficiente impostare il file di configurazione nel seguente modo:

```toml
[[redirects]]
  from = "https://rubynetti.netlify.com/*"
  to = "https://www.rubynetti.it/:splat"
  status = 301
  force = true
```
