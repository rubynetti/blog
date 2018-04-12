---
layout: post
title:  Introduzione a sigma.js
date:   2018-04-10 09:40:22 +0200
categories: sigma javascript
---

## Introduzione

Ogni istanza di **sigma.js** è basata su due elementi:

- [**graph model**](https://github.com/jacomyal/sigma.js/wiki/Graph-API)
- [**controller**](https://github.com/jacomyal/sigma.js/wiki/Public-API)

Il **graph model** è una parte di _sigma_ che aiuta nella manipolazione del dato.

Il **controller** fornisce metodi per interfacciarsi con il processo di rendering, i dati e l'applicazione.

## Camera API

### Aggiungere camera con impostazioni personalizzate

Per aggiungere una camera bisogna devi prima usare il metodo _add_camera_ e fornire un identificativo univoco.

Vedi esempio:

{% highlight javascript %}

  var sigma_instance = new sigma()

  var camera = sigma_instance.addCamera('animateZoom')

  sigma_instance.addRenderer({
    container: 'star-container',
    type: 'webgl',
    settings: {
      defaultLabelColor: '#000'
    },
    isAnimated: true
  })

{% endhighlight %}

Per spostare la camera:

{% highlight javascript %}
sigma_instance.camera.goTo({x: 1, y:10})
{% endhighlight %}

### Per animare la camera

sigma.misc.animation.camera


{% highlight javascript %}
  sigma.misc.animation.camera(sigma_instance.camera, {ratio: 0.2}, {duration: 1000})
{% endhighlight %}

## Referenze

- [sigma.js - Camera Api Wiki](https://github.com/jacomyal/sigma.js/wiki/Camera-API)
- [sigma.js - Sorgente di sigma.misc.animation](https://github.com/jacomyal/sigma.js/blob/master/src/misc/sigma.misc.animation.js)
