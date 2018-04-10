---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: post
---

# Backend

## Prima l'HTML

## Pensa in REST

Utilizzo di resource come strumento di guida.

Referenze:

- Derek Prior Think in Rest (trova il link)

## Pensa semplice

Meglio scrivere codice prevedibile piuttosto che codice smart.
Come linea guida pensa allo sviluppatore junior che dovrà prendere in mano il codice.
Scrivendo le cose in modo semplice e standard Rails anche lui potrà prendere
il codice in mano senza problema alcuno.

## Test

Dopo l'esplorazione per capire come affrontare il problema è importante realizzare almeno il test di integrazione almeno sul controller.
Spesso le tempistiche del cliente o le nostre stime ci impediscono uno sviluppo TDD corretto al 100%.

Altro elemento importante:
una volta individuato un bug è opportuno metterci sopra un test a guardia di eventuali ripetizioni del problema.

È importante ricordarsi di lanciare i test prima del rilascio compresi quelli di sistema.

---

# Frontend

## Organizzazione delle views

- Prepara i dati il più possibile prima di passarli alla view.
- La view dovrebbero avere meno logica possibile.
- Se si ha davanti una situazione complessa pensare ad un oggetto intermedio come un view object.
- Se il model è molto semplice può anche valer la pena di preparare i dati per la view all'interno del model.

{% highlight ruby %}
  # app/models/internal_data.rb

  class InternalData < ApplicationRecord

    validates :arca_id, presence: true, if: :cliente?

    def cliente?
      status_id == 2 ? true : false
    end

    def table_data
      [
        {
          label: self.class.human_attribute_name(:agent),
          value: agent.name_and_surname
        }
      ]
    end

  end
{% endhighlight %}

{% highlight ruby %}
  # app/views/internal_data/show.haml
  = render 'shared/table_rows', data: @internal_data.table_data
{% endhighlight %}

- Tieni in considerazione gli helper ma non abusarne.

## Bootstrap 3/4

## HAML / Pug

## VueJs / Stimulus


---

# Guida allo stile di scrittura del codice.

## Indentazioni in Ruby

### Hash

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
