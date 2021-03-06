---
layout: post
title: 'Docker: Adding the Dockerfile'
date: 2018-04-16T08:48:27.189Z
yoast_keyword: docker
description: Setup docker file for Rails Development.
categories: docker rails
toc: true
author: Giacomo Bertoldi
---

The Dockerfile is a simple text file that define the steps to build a Docker _image_ for a service.

Every instruction in it constitutes a layer on top of which the subsequent are built.
You should avoid creating too many, but it's good for readability and reusability that you keep different concepts in different layers.

The resulting image will be the "blank" state for our container to be run, so should already hold everything our service will need. It should not be changed too often but, if you keep it tidy and thin, working on it later during the app development won't be a problem.

I suggest creating a brand new app by ```rails new my-awesome-app``` to follow along with this tutorial.
You could actually use any existing application, but the db should be **SQLite** cause I'm not going to discuss connection with other databases in this post.

First thing we need to do is creating a file named _Dockerfile_ in the working directory of our application.

This is what we want to end up with
```Dockerfile
# /path-to-my-awesome-app/Dockerfile

# select the base image
FROM ruby:2.5

# install Node.js
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs

# set the working dir
WORKDIR /app

# add "rails" default user
RUN useradd -u 1000 -Um rails && \
    chown -R rails:rails /app
USER rails
```

Every line in it is explained in detail below.


#### Select the base image

First, we should choose an existing image to build on top of.
Since we want to dockerize a Ruby on Rails app, we can use one of the [Ruby images](https://hub.docker.com/_/ruby/) on the Docker Hub.

_FROM_ let us do that.
I'm choosing the latest release with ruby 2.5 on Debian.
```Dockerfile
FROM ruby:2.5
```


#### Install Node.js

We need Node.js to run a RoR app.
So in the next layer we install it, executing the same commands we would on any Debian machine.

We update quietly the sources and install it, along with Debian package builders.
```Dockerfile
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs
```

Notice we don't need to ```sudo```, since _root_ is the default user of most Docker images (including Ruby ones).


#### Set the the working directory

In the next layer we set the container's working directory,
where the application's files live.

WORKDIR will also create the directory since it doesn't exist yet.
```Dockerfile
WORKDIR /app
```


#### Create the _rails_ user

Since now, if you were to build and run a container from this image, its default user would be _root_.

This is ok in Docker containers for many types of services, but it's not convenient for a Rails one.
RoR apps are usually run by unprivileged users, so we should do in our container.

If we don't, many routine operations, like generating migrations, would mess with file permissions on the host machine
(since we are going to bind the host working directory to the one in the container for development).
Same goes for other commands like bundle, that is not supposed to be run as root. Doing so can lead to problems, both inside and outside the container (sure happened to me, anyway).

I feel much more comfortable running the service as an unprivileged user by default, than having to care how to interact with the container as a different user every time
(you sure can do that but I find it prone to mistakes).

Using _Debian_ standard syntax we create a _rails_  user with the default 1000 UID (or your user UID if different, you can find out by ```echo $UID```), belonging to a group with the same name and having a home directory.

```Dockerfile
RUN useradd -u 1000 -Um rails && \
```

In the same layer then we give the new user ownership of the app directory.

```Dockerfile
    chown -R rails:rails /app
```

#### Set the default user

With the _USER_ command we make rails the default user of the image.
```Dockerfile
USER rails
```

Every remaining command in the _Dockerfile_ will be run as this user,
as the main process of the service and the commands called from outside the container.


#### Building the image

That's it, there should be a _Dokerfile_ like [_this_](https://github.com/rubynetti/ror-docker-templates/blob/master/basic/Dockerfile) in the root of the application.

To build the image for the application we just need to
```
docker build path-to-my-awesome-app -t my-awsome-app
```

First argument for _docker build_ is the application's path (where the _Dockerfile_ is) and -t option tags the image with a custom name.

**Be aware** you may need to _sudo_ Docker commands, depending on your OS and user configuration.


#### Running the container

You can now run a new container from the image and start an interactive shell inside it like this
(_--rm_ option makes sure this container will be removed when we close it)
```
$ docker run --rm -it my-awesome-app bash
```

You'll find yourself to a prompt like this
```
rails@container_id:/app$
```

Not too exciting, huh?
There's almost nothing in it, just Debian and ruby.

You can try some commands in the _ruby shell_ to check everything is in place.
Then just exit the container for now.
```
rails@container_id:/app$ irb
irb(main):001:0> 2+2==5
=> false
irb(main):002:0> exit
rails@container_id:/app$ exit
```

In the next section, we are going to explore how to run a Rails app inside the container.


<hr/>

**Next step:**
[Running Rails Inside a Container]({% post_url 2018-05-01-running-a-ror-container %})

**Previous step:**
[Docker Development for Rails]({% post_url 2018-04-13-docker-rails-development %})
