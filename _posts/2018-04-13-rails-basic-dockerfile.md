---
layout: post
title: Adding the Dockerfile
categories: docker rails
author: Giacomo Bertoldi
---

The Dockerfile is a simple text file that set the steps to build the Docker _image_ for our service.

Every instruction in it constitutes a layer on top of which the subsequent are built.
You should avoid creating too many, but it's good for readability and reusability that you keep different concepts in different layers.

The resulting image will be the "blank" state for our container to be run, so should already hold everything our service will need. It should not be changed too often but, if you keep it tidy and thin, working on it later during the app development won't be a problem.

First thing we need to do is create a file named _Dockerfile_ in the working directory of our application.

This is what we want to end up with
```Dockerfile
# /path-to-my-awesome-app/Dockerfile

# select the base image
FROM ruby:2.5

# install Node.js
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs

# set the working dir
RUN mkdir /app
WORKDIR /app

# add "rails" default user
RUN useradd -u 1000 -Um rails && \
    chown -R rails:rails /app
USER rails
```

Every line in it is explained in detail below.


#### Select the base image

First, we should choose an existing image to build on top of.
Since we want to dockerize a Ruby on Rails app, we can use one of the [Ruby images](ciao) on the Docker Hub.

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


#### Create the working directory

In the next layer we just create a directory for the application files.
```Dockerfile
RUN mkdir /app
```


#### Set the the working directory

Then we set the newly created directory as the default one for the image.
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

Using _Debian_ standard syntax we create a _rails_  user with the default 1000 UID, belonging to a group with the same name and having a home directory. 
```Dockerfile
RUN useradd -u 1000 -Um rails && \
```
In the same layer then we give the new user ownership of the app directory.
```Dockerfile
    chown -R rails:rails /app
```

#### Set the default user

With the _USER_ command we make rails the default user of the image.

Every remaining command in the _Dockerfile_ will be run as this user,
as the main process of the service and the commands called from outside the container.
```Dockerfile
USER rails
```

#### Building the image

That's it, there should be a _Dokerfile_ like [_this_](https://github.com/rubynetti/ror-docker-templates/blob/master/basic/Dockerfile) in the root of the application.

To build the image for our container we just need to ```sudo docker build . my-awsome-app```
(_sudo_ may not be necessary, depending on you OS and user configuration).


#### Running the container

You can now run a new container from the image and start an interactive shell inside it like this
(```--rm``` option makes sure this container will be removed when we close it).
```
$ sudo docker run --rm -it my-awesome-app bash
```
You'll find yourself to a prompt like this
```
root@container_id:/app#
```

Not too exciting, huh?
There's almost nothing in it, just Debian and ruby.

You can try some commands on the _ruby shell_ to check everything is in place.
Then just exit the container for now.
```
root@container_id:/app# irb
irb(main):001:0> 2+2==5
=> false
irb(main):002:0> exit
root@container_id:/app# exit
```

In the next section, we are going to explore how to execute a Rails app inside a container like this.


<hr/>

**Previous step:**
[Docker Development for RoR](/_posts/2018-04-13-docker-rails-development.md)

**Next step:**
Running RoR Inside a Container _(coming soon)_
