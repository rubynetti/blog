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

---

# Frontend

## Organizzazione delle views

- Prepara i dati il più possibile prima di passarli alla view.
- La view dovrebbero avere meno logica possibile.
- Se si ha davanti una situazione complessa pensare ad un oggetto intermedio come un view object.
- Tieni in considerazione gli helper ma non abusarne.

## Bootstrap 3/4

## HAML / Pug

## VueJs / Stimulus


---

# Style Guide

## Indentazioni in Ruby

### Hash

Preferire la leggibilità e lo spazio tra gli elementi.

{% highlight ruby %}

# Bad

{ label: "test 1",
  value: 1 },
{ label: "test 2",
  value: 2 }

# Good

{
  label: "test 1",
  value: 1
},
{
  label: "test 2",
  value: 2
}
{% endhighlight %}
