---
layout: post
title:  SigmaJS
date:   2018-04-10 09:40:22 +0200
categories: sigma javascript
---

Ogni istanza di sigma è basata su due elementi:

- [**graph model**](https://github.com/jacomyal/sigma.js/wiki/Graph-API)
- [**controller**](https://github.com/jacomyal/sigma.js/wiki/Public-API)

Il **graph model** è una parte di sigma che aiuta nella manipolazione del dato.
Il **controller** fornisce metodi per interfacciarsi con il processo di rendering, i dati e la tua applicazione.


{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}
