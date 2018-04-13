# Docker Development for Ruby on Rails


## Why?

During the last six months I started using Docker to host my (mostly RoR) apps in development.
The main reason I started studying it was not hype nor need, it was just the my recurring impulse to learn something new.
You can find everything you need to install and setup Docker and Compose on [the official documentation](https://docs.docker.com/).

There is even a guide to bootstrap a RoR app with Docker [here](https://docs.docker.com/compose/rails/).
I found a number of example dockerfiles (and docker-compose files) around, but mainly focused on deploy and not working for development, for me, or at all sometimes.

So, I decided to write down the solutions I came up with as for now, in case anyone was struggling as I was :)


## Yes, but why?

The main thing I love about dockerizing my apps, is the ability to launch them without having to configure (almost) anything on the hosting machine, either in developent or production.

Working on linux I like to change distro every know and then. Everytime I needed to install and configure many packages in many versions. Yes I could script most of that, but i discovered I like to have a clean machine, with just the strict necessary for generic activities.

I don't need to install/reinstall every version of ruby i use in every project I own, nor I do have to install every library i did in the past, just to pick up again an old project.

Everything is as simple as typing `sudo docker-compose up` (actually i made an abbr for that. Did I talk about [fish](https://fishshell.com/) yet?)


## Anithing else?

You can find a load of articles talking about the pros and cons of tecnici e pratici

Something that really made the difference for me was having the same environment in development and production. More than some times I found my apps working on my machine and breaking in some way on the server. Not anymore, containers configuration is the same on any machine and any other i can install my app in.

As I said before, nothing to configure, you pull the images and are ready to go!

Another perk i enjoy is the possibility to try any sort of software upgrade in the container, without risk. If something breaks, you just go back to the previous version of your docker files.


## So, I'm a RoR developer wishing to try Docker, what sould I do?
* [install docker](https://docs.docker.com/)
* [install docker-compose](https://docs.docker.com/compose/install/)

Official guides are very detailed and always up to date, i reccomend to carefully read and follow every installation step for you OS. If you are on Linux i really suggest to install compose [shell completions](https://docs.docker.com/compose/completion/). [Available for fish also!](https://github.com/docker/compose/blob/master/contrib/completion/fish/docker-compose.fish)
Every Docker and Compose command is explained in detail, 

guida

