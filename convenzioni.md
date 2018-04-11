---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
title: Convenzioni per progetti Ruby On Rails
---

## Introduzione

Queste sono alcune delle convenzioni e delle decisioni che abbiamo preso come squadra di lavoro per quanto riguarda le applicazioni che scriviamo con il framework Ruby On Rails.  
Chi conosce il framework ci vedrà una discreta soggettività e probabilmente anche molte lacune ma in ogni caso questo è inteso come l'inizio di un percorso di decisioni che progressivamente vorremo migliorare e riempire.

## Backend

### Prima l'HTML

Anche se il cliente chiede un determinato dato in Excel o in un formato X è sempre conveniente _rimanere sui binari_ e realizzare comunque una visualizzazione del dato in html ancor prima di realizzare la visualizzazione del dato nel formato richiesto.  
In questo modo diventa molto facile pensare contemporaneamente in Railsese e soddisfare in modo efficace il cliente.  
È inoltre semplice per tutti esplorare il codice e poterlo migliorare o modificare a seconda delle necessità.

### Pensa in REST

Utilizzo di risorse REST resource come strumento di guida.

Referenze:

- [Derek Prior - In Relentless Pursuit of REST](In Relentless Pursuit of REST)
- [Form Objects](https://robots.thoughtbot.com/activemodel-form-objects)

### Pensa semplice, noioso è meglio.

Meglio scrivere codice prevedibile piuttosto che codice smart.
Come linea guida pensa allo sviluppatore junior che dovrà prendere in mano il codice.
Scrivendo le cose in modo semplice e standard Rails anche lui potrà prendere
il codice in mano senza problema alcuno.
Meglio codice noioso chiaro che un codice brillante difficile da decodificare per gli altri sviluppatori.

### Test

Dopo l'esplorazione per capire come affrontare il problema è importante realizzare almeno il test di integrazione almeno sul controller.
Spesso le tempistiche del cliente o le nostre stime ci impediscono uno sviluppo TDD corretto al 100%.

Altro elemento importante:
una volta individuato un bug è opportuno metterci sopra un test a guardia di eventuali ripetizioni del problema.

È importante ricordarsi di lanciare i test prima del rilascio compresi quelli di sistema.

### Programmare in coppia
Il _pair programming_ è in generale una ottima idea.  
Quando è possibile meglio farlo.  
Se si programma da soli è importante ricordarsi di condividere con la squadra di lavoro le parti più complesse.

## Frontend

### Organizzazione delle views

Abbiamo valutato molte alternative tra cui:

- Utilizzo avanzato dei partial
- Decoratori: [Draper](https://github.com/drapergem/draper)
- Layer aggiuntivi: [Cell](https://github.com/trailblazer/cells)
- Oggetti ruby semplici (Poro Object)
- View Object
- Framework JS seperati

Per quanto molte di queste strategie sono certamente intelligenti aggiungono complessità e lavoro e non ci hanno mai soddisfatto al 100%.

Per chiarezza al momento stiamo utilizzando una tecnica inizialmente emersa grazie all'uso di VueJs (e quindi alla necessità di dover forzatamente distinguere alcune fasi nella comunicazioni dei dati tra una parte e l'altra dell'applicazione).

La tecnica è molto semplice e si basa esclusivamente sull'uso degli strumenti base di Rails.

Sappiamo che la tecnica indviduata è decisamente poco ortodossa rispetto ai principi classici che vengono esposti dagli _esperti_ ma risulta molto comoda e capace almeno per ora di coprire egregiamente i nostri casi.

{% highlight haml %}
  -# show.haml
  :ruby
    data = [
      {
        label: BusinessArea::InternalData.human_attribute_name(:agent),
        value: link_to_if(@business.agent.present?, @business.agent.name_and_surname, @business.agent)
      },
      {
        label: BusinessArea::InternalData.human_attribute_name(:arca_id),
        value: @business.arca_id
      }
    ]

  = render 'shared/table', data: data
{% endhighlight %}

Nel caso in cui l'hash diventi complesso non disdegniamo l'uso di classi ruby al cui interno includere gli helper della view.

{% highlight ruby %}
class BusinessArea::AdminMenuView
  delegate :url_helpers, to: 'Rails.application.routes'
  # [...]

  def financial_url
    url_helpers.admin_business_financial_infos_path(@business)
  end
end
{% endhighlight %}

### Principi che abbiamo valutato (ma non necessariamente adottato)

- Prepara i dati il più possibile prima di passarli alla view.
- La view dovrebbero avere meno logica possibile.
- Se si ha davanti una situazione complessa pensare ad un oggetto intermedio come un view object.
- Se il model è molto semplice può anche valer la pena di preparare i dati per la view all'interno del model.
- Tieni in considerazione gli helper ma non abusarne.

### Bootstrap 3/4

### HAML / Pug

L'uso di [HAML](http://haml.info/), [Pug](https://pugjs.org/api/getting-started.html), [Slim](http://slim-lang.com/) rende il codice HTML un piacere da leggere e da scrivere.
Inoltre rende assai più semplice il debug.
Per quello adottiamo ogni volta che possiamo questo genere di strumenti.
Generalmente usiamo HAML perchè è lo strumento con cui abbiamo più esperienza.

### VueJs / Stimulus

## Guida allo stile di scrittura del codice.

### Indentazioni in Ruby

#### Hash

Preferire la leggibilità e lo spazio tra gli elementi.

{% highlight ruby %}

# Bad

[{ label: "test 1",
  value: 1 },
{ label: "test 2",
  value: 2 }]

# Good

[
  {
    label: "test 1",
    value: 1
  },
  {
    label: "test 2",
    value: 2
  }
]

{% endhighlight %}
