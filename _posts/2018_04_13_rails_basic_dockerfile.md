## Adding the Dockerfile

The Dockerfile is a simple text file that set the steps to build the Docker _image_ for our service.

Every instruction in it constitutes a layer on top of which the subsequents are built.
You should avoid creating too many, but it's good for readability and reusability that you keep different concepts in different layers.

The resulting image will be the "blank" state for our container to be run, so should already contain everything our service will need. It should not be changed too often but, if you keep it tidy and thin, working on it later during the app development won't be a problem.

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
Since we want to dockerize a Ruby on Rails up, we can use one of the [Ruby images](ciao) on the Docker Hub.

_FROM_ let us do that.
I'm choosing the latest release with ruby 2.5 on Debian.
```Dockerfile
FROM ruby:2.5
```


#### Install Node.js

We need Node.js to run a RoR app so in the next layer we will install it, executing the same commands we would on our machine.
So we update quietly the sources and install it, along with debian package builders.

Notice we don't need to ```sudo```, since _root_ is the default user of most Docker images (including Ruby ones).
```Dockerfile
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs
```


#### Create the working directory

In the next layer we just create a container directory for the application files.
```Dockerfile
RUN mkdir /app
```


#### Set the the working directory

Then we set the newly created directory as the default one for the container.
```Dockerfile
WORKDIR /app
```


#### Create the _rails_ user

Since now, if you were to build and run a container with this image, default user would be _root_.

This is right for many types of services, but it's not convinient for a Rails container.
Rails apps are usually run by unprivilaged users, so we should do in our container.

If we don't, many routine operations, like generating migrations, would mess with file permissions on the host machine
(since we are going to bind the host working directory to the one in the container for development).
Same goes for other commands like bundle, that is not supposed to be run as root and can lead to problems, both inside and ouside the container.

Sure happened to me, by the way.
I feel much more comfortable running the service as an unprivileged user by default, than having to be careful every time how to interact with the container
(you sure can "log" in the container as any user, but it's not a solid approach in my opinion).
Using _Debian_ standard syntax we create a **rails**  user with the default 1000 UID, belonging to a group with the same name and having a home directory. 

In the same layer, we give the new user ownership of the app directory.
```Dockerfile
RUN useradd -u 1000 -Um rails && \
    chown -R rails:rails /app
```

#### Set the default user

With the _USER_ command we then make rails the default user of the container.

Every remaining command in the _Dockerfile_ will be run as this user,
as the main process of the service and the commands that will be called from outside the container.
```Dockerfile
USER rails
```

#### Building the container

That's it, we should have a _Dokerfile_ like [_this_](https://github.com/rubynetti/ror-docker-templates/blob/master/basic/Dockerfile) in the root of our application.

To build the image for our container we just need to ```sudo docker build . my-awsome-app```
(_sudo_ may not be necessary, depending on you OS and user configuration)


#### Running the container

You can now run the container and start an interactive shell inside it like this
``` sudo docker run --rm -p 3000:3000 -v "$(pwd)":/app -it trellohours_web bash```
Inside you can do all usual staff like running bundler and migrations.

It's very long and we have just started a shell, not the actual RoR application so where do we go from here?

Configuration is verbose and clumsy using Docker alone, that's where [Compose](https://docs.docker.com/compose/) come to help!


<hr/>

**Previous step:**
[Docker Development for RoR](/_posts/2018-04-13-docker-rails-development.md)

**Next step:**
Adding docker-compose.yml _(coming soon)_
