Introduction
=============

What is Sinatra?
----------------
Sinatra is a Domain Specific Language (DSL) for quickly creating
web-applications in Ruby.

It keeps a minimal feature set, leaving the developer to use the
tools that best suit them and their application.

It doesn't assume much about your application, apart from that:

* it will be written in Ruby programming language
* it will have URLs

In Sinatra, you can write short _ad hoc_ applications or mature, larger
application with the same easiness.

You can use the power of various Rubygems and other libraries available for
Ruby.

Sinatra really shines when used for experiments and application mock-ups or for
creating a quick interface for your code.

It isn't a _typical_ Model-View-Controller framework, but ties specific URL
directly to relevant Ruby code and returns its output in response. It does
enable you, however, to write clean, properly organized applications:
separating _views_ from application code, for instance.

Installation
------------
The simplest way to install Sinatra is through Rubygems:

    $ gem install sinatra

### Dependencies

Sinatra depends on the _Rack_ gem (<http://rack.rubyforge.org>).

Sinatra supports many different template engines (it uses the Tilt library
internally to support practically every template engine in Ruby)
For optimal experience, you should install the template engines you want to
work with.  The Sinatra dev team suggests using either ERB, which is included
with Ruby, or installing HAML as your first template language.

    $ gem install haml

### Living on the Edge

The _edge_ version of Sinatra lives in its Git repository, available at 
**<http://github.com/sinatra/sinatra/tree/master>**.

You can use the _edge_ version to try new functionality or to contribute to the
framework. You need to have [Git version control
software](http://www.git-scm.com) and [bundler](http://gembundler.com/).

    gem install bundler

To use Sinatra _edge_ with bundler, you'll have to create a `Gemfile` listing
Sinatra's and any other dependencies you're going to need.

    source :rubygems
    gem 'sinatra', :git => 'git://github.com/sinatra/sinatra.git'

Here we use the gemcutter source to specify where to get Sinatra's
dependencies; alternatively you can use the git version, but that is up to you.
So now we can install our bundle:

    bundle install

Hello World Application
-----------------------

Sinatra is installed, how about making your first application?

    require 'rubygems'

    # If you're using bundler, you will need to add this
    require 'bundler/setup'
    
    require 'sinatra'
    
    get '/' do
      "Hello world, it's #{Time.now} at the server!"
    end

Run this application by `$ ruby hello_world.rb` and load
`http://localhost:4567` in your browser.

As you can see, Sinatra doesn't force you to setup much infrastructure: a
request to a URL evaluates some Ruby code and returns some text in response.
Whatever the block returns is sent back to the browser.


Real World Applications in Sinatra
----------------------------------

### Github Services

Git hosting provider Github uses Sinatra for post-receive hooks, calling user
specified services/URLs, whenever someone pushes to their repository:

* <http://github.com/blog/53-github-services-ipo>
* <http://github.com/guides/post-receive-hooks>
* <http://github.com/pjhyett/github-services>

Check out a full list of Sinatra apps [in the wild][in-the-wild].

[in-the-wild]: http://www.sinatrarb.com/wild.html

About this book
---------------
This book will assume you have a basic knowledge of the Ruby scripting language
and a working Ruby interpreter.

For more information about the Ruby language visit the following links:

* [ruby-lang](http://www.ruby-lang.org)
* [ruby-lang / documentation](http://www.ruby-lang.org/en/documentation/)

Need Help? 
----------

The Sinatra club is small, but super-friendly.  Join us on IRC at
irc.freenode.org in #sinatra if you have any questions.  It's a bit
slow at times, so give us a bit to get back to your questions.

