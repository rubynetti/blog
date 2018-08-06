---
layout: post
title: >-
  Minitest: how to test tag title in a Rails Project? The simplest way is using
  assert_select method.
date: 2018-08-06T06:12:32.159Z
yoast_keyword: minitest
description: >-
  Minitest for test tag title. How to do it? It's very easy with assert_select.
  I use meta tag gem with Rails and i do often errors so i need it.
categories: 'rails, test'
toc: false
---
![Minitest with Rails - list of title books](/images/uploads/annie-spratt-303944-unsplash.jpg)

I need to test often about _title tag_ for SEO reason. The title tag is very important for Google and search motors for obvious reasons: is the title of the page and the first thing that user see when he have to choose a result from the search. How to test with **minitest** inside _Rails_?

I use the meta-tag gem and sometimes I do errors so I choose to put this part under version control for a project like [significatocanzone.it](https://significatocanzone.it) where SEO is a very important topic.

Rails guides is not very preoccupied with testing views issue. There are only one chapter and very small about it. But I'm lucky because the first example is exactly about my concern.

The solutions is use assert_select in this way:

![Assert select rails minitest](/images/uploads/assert-select-rails.png)
