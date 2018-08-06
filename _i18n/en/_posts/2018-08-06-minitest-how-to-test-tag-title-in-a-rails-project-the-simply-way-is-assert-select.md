---
layout: post
title: >-
  Minitest: how to test tag title in a Rails Project? The simply way is assert
  select.
date: 2018-08-06T06:12:32.159Z
yoast_keyword: minitest
description: >-
  Minitest for test tag title. How to do it? It's very easy with assert_select.
  I use meta tag gem with Rails and i do often errors so i need it.
categories: 'rails, test'
toc: false
---
# How to test with **minitest** the **title tag** inside a Rails project?

I need to test often about *title tag* for seo reason.
The title tag is very important for Google and search motors for obvious reasons: it is the title of the page and the first thing that user see when choose a result from search.
How to test with **minitest** inside Rails?

I use the meta-tag gem and sometimes i write errors often so i choose to put this part under version control for project like significatocanzone.it where seo is very important topic.

![Minitest with Rails - list of title books](/images/uploads/annie-spratt-303944-unsplash.jpg)

Rails way is not very preoccupied about testing views issue.
There is only one chapter and very small about it.
But I'm Lucky because the first example is exactly about my concern.

```ruby
assert_select 'title', "Welcome to Rails Testing Guide"
```

This to me seems the most easy way to test tag title.
