---
layout: post
title: Docker Development for Ruby on Rails
---


## Why?

During the last six months, I started using Docker to host my (mostly RoR) apps in development.
The main reason I started studying it was not hype nor need, it was just my recurring impulse to learn something new.
You can find everything you need to install and setup Docker and Compose in [the official documentation](https://docs.docker.com/).

There is even a guide to bootstrap a RoR app with Docker [here](https://docs.docker.com/compose/rails/).
I found a number of example _Dockerfiles_ (and _docker-compose_ files) around but mainly focused on deploy. They did not work either for development, for me, or at all sometimes.

So, I decided to write down the solutions I came up with as for now, in case anyone was struggling as I was :)


## Yes, but why should I dockerize my app?

The main thing I love is not having to configure (almost) anything on the hosting machine, either in development or production.

Working on Linux I like to change distro every now and then. Every time I needed to install and configure many packages, in many versions. Yes I could script most of that, but I discovered I like to have a clean machine, with just the strict necessary for generic activities.

I don't need to install/reinstall every version of ruby I use in every project I own, nor I do have to install every library I did in the past, just to pick up again an old project.

Everything is as simple as typing `sudo docker-compose up` (actually I made an abbr for that. Did I talk about [fish](https://fishshell.com/) yet?)


## Anything else?

You can find a load of articles talking about the pros and cons of containerize your application, both on a technical and a practical level.

Something that really made the difference for me was having the same environment in development and production. More than sometimes I found my apps working on my machine and breaking in some way on the server. Not anymore, containers configuration is the same on any machine and any other I can install my app on.

As I said before, nothing to configure, you pull the images and are ready to go!

Another perk I enjoy is the possibility to try any sort of software upgrade in the container, without risk. If something breaks, you just go back to the previous version of your docker files.


## So, I'm a Ruby on Rails developer wishing to try Docker, what should I do?
* [install docker](https://docs.docker.com/)
* [install docker-compose](https://docs.docker.com/compose/install/)

Official guides are very detailed and always up to date, i recommend to carefully read and follow every installation step for your OS. If you are working on Linux I really suggest installing Compose [shell completions](https://docs.docker.com/compose/completion/) also.

[Dockerfile](https://docs.docker.com/engine/reference/builder/)
and [Compose](https://docs.docker.com/compose/compose-file/)
references were very useful for me. Every command and option is explained clearly and in depth.

After that, you just have to add a couple of files to your project to configure its containers.

<hr/>

**Next step:** [Adding the Dockerfile](docker-2-parte)
