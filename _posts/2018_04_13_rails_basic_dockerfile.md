## Adding the Dockerfile
The Dockerfile is a simple text file that set the layers for building the image of our service.
Every instruction we write is a layer on top of which the others are built, and averyone is **cached**.
You should avoid creating too many, but it's good for readability and reusability that you keep different actions in different layers.
We just have to create a file named _Dockerfile_ in the working directory of our application and edit it.

#### Select the base image
First, we should choose an existing image on top of wich we can build it.
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

#### Set the working directory


#### Create the user
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
With the _USER_ command we then make rails the default user of the container.
Every remaining command in the _Dockerfile_ will be run as this user,
as the main process and the commands that will be called from outside the container.
```Dockerfile
USER rails
```