Deployment
==========

Heroku
------

This is the easiest configuration + deployment option.  [Heroku] has full
support for Sinatra applications.   Deploying to Heroku is simply a matter of
pushing to a remote git repository.

Steps to deploy to Heroku:

* Create an [account](http://heroku.com/signup) if you don't have one
* `gem install heroku`
* Make a config.ru in the root-directory
* Create the app on heroku
* Push to it

1. Here is an example config.ru file that does two things.  First, it requires
   your main app file, whatever it's called. In the example, it will look for
   `myapp.rb`.  Second, run your application.  If you're subclassing, use the
   subclass's name, otherwise use Sinatra::Application.

        require "myapp"

        run Sinatra::Application

2. Create the app and push to it

       From the root-directory of the application

       $ heroku create <app-name>  # This will add heroku as a remote
       $ git push heroku master

For more details see [this](http://github.com/sinatra/heroku-sinatra-app)

[Heroku]: http://www.heroku.com

Cloud Foundry
-------------

This describes how to deploy a classic style Sinatra app on Cloud Foundry:

1. Create a free [account](http://cloudfoundry.com/signup) if you don't have one already
1. Install the `vmc` Ruby gem

        $ gem install vmc

1. Target the cloudfoundry.com instance and log in

        $ vmc target api.cloudfoundry.com
        Succesfully targeted to [http://api.cloudfoundry.com]
        $ vmc login
        Email: you@gmail.com
        Password: ********
        Successfully logged into [http://api.cloudfoundry.com]

1. Go to the root directory of your application, e.g.

        $ cd ~/ruby/sinatra/my-app

1. Deploy the application with

        $ vmc push -n my-app
        Creating Application: OK
        Uploading Application:
          Checking for available resources: OK
          Packing application: OK
          Uploading (2K): OK   
        Push Status: OK
        Staging Application: OK                                                         
        Starting Application: OK

You are now able to access your application at [http://my-app.cloudfoundry.com](http://my-app.cloudfoundry.com)

For a working example you can use as a template, see [this code](https://github.com/pmenglund/cf-rake-sinatra)
