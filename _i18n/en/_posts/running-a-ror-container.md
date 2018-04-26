## Running Rails inside a Container

In the [previous_step](ciaosonounlink) we built the image and run a container ready for a Rails app.
Now we are going to run the app inside that.
We won't dive into _[Compose](altrolink)_ yet and use just Docker to do that.


#### Binding the working directory

First thing to do is to copy the application files inside the container.
We could do that by using an _ADD_ instruction in the _Dockerfile_,
but rebuilding the image after any change during development would not be susteinable.
So we bind the working directory of the project to the one in the container.
_-v (source:destination)_ option let us do that
When source is a path this will bind that path to the destination in the container.
You can use $PWD as the source path if you cd to the application path.
```
$ docker run --rm -it -v /path-to-my-awesome-app:/app my-awesome-app bash
rails@container-id:/app$
```
If you ```ls``` you should see all the application files, including the _Gemfile_.


#### Start the application

You can now bundle as you usually would
```
rails@container-id:/app$ bundle
Fetching gem metadata from https://rubygems.org/......
Fetching rake 12.3.0
Installing rake 12.3.0
Fetching concurrent-ruby 1.0.5
.
.
.
Bundle complete! 23 Gemfile dependencies, 105 gems now installed.
Bundled gems are installed into `/usr/local/bundle`
```

Migrate the database
```
rails@container-id:/app$ rails db:migrate
```

And finally run the application
```
rails@container-id:/app$ rails s
=> Booting Puma
=> Rails 5.2.0 application starting in development
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.11.4 (ruby 2.5.0-p0), codename: Love Song
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```
