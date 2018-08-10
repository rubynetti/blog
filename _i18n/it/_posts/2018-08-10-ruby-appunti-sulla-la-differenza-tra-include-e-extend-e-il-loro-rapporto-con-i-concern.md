---
layout: post
title: >-
  Ruby appunti sulla la differenza tra include e extend e il loro rapporto con i
  Concern di Rails.
date: 2018-08-10T09:34:18.787Z
yoast_keyword: include
description: Appunti per scoprire la differenza tra include e extend.
categories: Ruby
toc: false
author: Alessandro
---
# Includi oppure estendi?

In Ruby quando bisogna usare _include_ oppure _extend_?
Quale è la differenza tra i due metodi?

Entrambi gli strumenti servono a portare all'interno delle classi delle porzioni di codice appartenenti ai moduli.

Stavo creando un concern all'interno del progetto Rails [momento.cc](http://momento.cc).  
Per l'ennesima volta ho per errore confuso un metodo con l'altro.

Per far funzionare il meccanismo dei Concern è infatti necessario scrivere extend ActiveSupport::Concern.

## Quali sono le differenze tra i due metodi?

La differenza è relativamente semplice:

- **include** aggiunge i metodi alla istanza della classe.
- **extend** aggiungi metodi di classe.

Quindi si usa il primo quando si vogliono aggiungere dei metodi all'oggeto istanziato e viene usato nella maggior parte dei casi.

Vi sono numerosi articoli sul web che spiegano la differenza.
Spero che scrivere questi appunti mi aiuti a memorizzare in modo chiaro la differenza.

## Ma perchè si usano i Concern allora?

I concern sono un modo comodo per avere in un solo file sia i metodi di classe che i metodi di istanza.  
Infatti una volta incluso _ActiveSupport::Concern _si può usare il metodo _included_ col quale infilare nella classe anche dei metodi di istanza senza dover ricorrere all'uso di seperare la struttura in ulteriori moduli sui quale fare extend.  
Inoltre i _concern_ permettono di concatenare diversi moduli.
A riguardo la spiegazione della [guida ufficiale](https://api.rubyonrails.org/classes/ActiveSupport/Concern.html#method-i-included) è decisamente esauriente.

## La struttura delle chiamate

Questo [articolo di Leonard Hetsch](https://medium.com/@leo_hetsch/ruby-modules-include-vs-prepend-vs-extend-f09837a5b073) mostra chiaramente la struttura delle chiamate in un oggetto ruby e la relativa catena.
L'articolo si dilunga inoltre a spiegare invece il significato di un ulteriore strumento disponibile da Ruby versione 2: prepend.
