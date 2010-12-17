Views
=====

All file-based view files should be located in the directory `./views/`:

    root
      | - views/

You access these views by calling various view helpers. These are methods that
lookup the template, render it, and return a string containing the rendered
output. These view methods do not return anything to the browser by
themselves. The only output to the browser will be the return value of the
handler block.

To use a different view directory:

    set :views, File.dirname(__FILE__) + '/templates'

One important thing to remember is that you always have to reference templates
with symbols, even if they’re in a subdirectory, in this case use
`:subdir/template`. You must use a symbol because otherwise rendering methods
will render any strings passed to them directly.

Template Languages
------------------

### Erb

    ## You'll need to require erb in your app
    require 'erb'

    get '/' do
      erb :index
    end

This will render ./views/index.erb

### Haml

The haml gem/library is required to render HAML templates:

    set :haml, :format => :html5 # default Haml format is :xhtml

    get '/' do
      haml :index, :format => :html4 # overridden
    end

This will render ./views/index.haml

[Haml's
options](http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html#options) can
be set globally through Sinatra’s configurations, see [Options and
Configurations](#configuration), and overridden on an individual basis. 

### Erubis

The erubis gem/library is required to render erubis templates:

    ## You'll need to require erubis in your app
    require 'erubis'

    get '/' do
      erubis :index
    end

Render `./views/index.erubis`

### Nokogiri

The nokogiri gem/library is required to render nokogiri templates:

    ## You'll need to require nokogiri in your app
    require 'nokogiri'

    get '/' do
      nokogiri :index
    end

Renders `./views/index.nokogiri`.



### Builder

The builder gem/library is required to render builder templates:

    ## You'll need to require builder in your app
    require 'builder'

    get '/' do
      builder :index
    end

This will render ./views/index.builder

    get '/' do
      builder do |xml|
        xml.node do
          xml.subnode "Inner text"
        end
      end
    end

This will render the xml inline, directly from the handler.

#### Atom Feed

#### RSS Feed
Assume that your site url is http://liftoff.msfc.nasa.gov/.

    get '/rss.xml' do
      builder do |xml|
        xml.instruct! :xml, :version => '1.0'
        xml.rss :version => "2.0" do
          xml.channel do
            xml.title "Liftoff News"
            xml.description "Liftoff to Space Exploration."
            xml.link "http://liftoff.msfc.nasa.gov/"

            @posts.each do |post|
              xml.item do
                xml.title post.title
                xml.link "http://liftoff.msfc.nasa.gov/posts/#{post.id}"
                xml.description post.body
                xml.pubDate Time.parse(post.created_at.to_s).rfc822()
                xml.guid "http://liftoff.msfc.nasa.gov/posts/#{post.id}"
              end
            end
          end
        end
      end
    end

This will render the rss inline, directly from the handler.

### Sass

The sass gem/library is required to render Sass templates:

    ## You'll need to require sass in your app
    require 'sass'

    get '/' do
      sass :styles
    end

This will render `./views/styles.sass`

[Sass'
options](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#options) can
be set globally through Sinatra's configuration, see [Options and
Configurations](#configuration), and overridden on an individual basis.

    set :sass, :style => :compact # default Sass style is :nested

    get '/stylesheet.css' do
        sass :stylesheet, :style => :expanded # overridden
    end

### Scss Templates

The sass gem/library is required to render Scss templates:

    ## You'll need to require haml or sass in your app
    require 'sass'

    get '/stylesheet.css' do
      scss :stylesheet
    end

Renders `./views/stylesheet.scss`.

[Scss' options](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#options)
can be set globally through Sinatra's configurations,
see [Options and Configurations](#configuration),
and overridden on an individual basis.

    set :scss, :style => :compact # default Scss style is :nested

    get '/stylesheet.css' do
      scss :stylesheet, :style => :expanded # overridden
    end

### Less Templates

The less gem/library is required to render Less templates:

    ## You'll need to require less in your app
    require 'less'

    get '/stylesheet.css' do
      less :stylesheet
    end

Renders `./views/stylesheet.less`.

### Liquid Templates

The liquid gem/library is required to render Liquid templates:

    ## You'll need to require liquid in your app
    require 'liquid'

    get '/' do
      liquid :index
    end

Renders `./views/index.liquid`.

Since you cannot call Ruby methods, except for `yield`, from a Liquid
template, you almost always want to pass locals to it:

    liquid :index, :locals => { :key => 'value' }

### Markdown Templates

The rdiscount gem/library is required to render Markdown templates:

    ## You'll need to require rdiscount in your app
    require "rdiscount"
  
    get '/' do
      markdown :index
    end

Renders `./views/index.markdown` (+md+ and +mkd+ are also valid file
extensions).

It is not possible to call methods from markdown, nor to pass locals to it. You
therefore will usually use it in combination with another rendering engine:

    erb :overview, :locals => { :text => markdown(:introduction) }

Note that you may also call the markdown method from within other templates:

    %h1 Hello From Haml!
    %p= markdown(:greetings)

### Textile Templates

The RedCloth gem/library is required to render Textile templates:

    ## You'll need to require redcloth in your app
    require "redcloth"

    get '/' do
      textile :index
    end

Renders `./views/index.textile`.

It is not possible to call methods from textile, nor to pass locals to it. You
therefore will usually use it in combination with another rendering engine:

    erb :overview, :locals => { :text => textile(:introduction) }

Note that you may also call the textile method from within other templates:

    %h1 Hello From Haml!
    %p= textile(:greetings)

### RDoc Templates

The RDoc gem/library is required to render RDoc templates:

    ## You'll need to require rdoc in your app
    require "rdoc"

    get '/' do
      rdoc :index
    end

Renders `./views/index.rdoc`.

It is not possible to call methods from rdoc, nor to pass locals to it. You
therefore will usually use it in combination with another rendering engine:

    erb :overview, :locals => { :text => rdoc(:introduction) }

Note that you may also call the rdoc method from within other templates:

    %h1 Hello From Haml!
    %p= rdoc(:greetings)

### Radius Templates

The radius gem/library is required to render Radius templates:

    ## You'll need to require radius in your app
    require 'radius'

    get '/' do
      radius :index
    end

Renders `./views/index.radius`.

Since you cannot call Ruby methods, except for `yield`, from a Radius
template, you almost always want to pass locals to it:

    radius :index, :locals => { :key => 'value' }

### Markaby Templates

The markaby gem/library is required to render Markaby templates:

    ## You'll need to require markaby in your app
    require 'markaby'

    get '/' do
      markaby :index
    end

Renders `./views/index.mab`.

### CoffeeScript Templates

The coffee-script gem/library and the `coffee` binary are required to render
CoffeeScript templates:

    ## You'll need to require coffee-script in your app
    require 'coffee-script'

    get '/application.js' do
      coffee :application
    end

Renders `./views/application.coffee`.

### Inline Templates

    get '/' do
      haml '%div.title Hello World'
    end

Renders the inlined template string.


Subdirectories in views
-----------------------

In order to create subdirectories in `./views/`, first you need to just create the
directory structure.  As an example, it should look like:

    root
      | - views/
        | - users/
          | - index.haml
          | - edit.haml

Then you can call the haml view helper with a symbol pointing to the path of the view.
There's a syntax trick for this in ruby, to convert a string to a symbol.  

    :"users/index"
    
You can also use the more verbose version of the same thing:

    "users/index".to_sym


Layouts
-------

Layouts are simple in Sinatra.  Put a file in your views directory named
"layout.erb", "layout.haml", or "layout.builder".  When you render a page, the
appropriate layout will be grabbed, of the same filetype, and used.

The layout itself should call `yield` at the point you want the content to be
included.

An example haml layout file could look something like this:

    %html
      %head
        %title SINATRA BOOK
      %body
        #container
          = yield

### Avoiding a layout
Sometimes you don't want the layout rendered.  In your render method just
pass `:layout => false`, and you're good.

    get '/' do
      haml :index, :layout => false
    end

### Specifiying a custom layout

If you want to use a layout not named "layout", you can override the name
that's used by passing `:layout => :custom_layout`

    get '/' do
      haml :index, :layout => :custom_layout
    end

In File Views
-------------

For your micro-apps, sometimes you don't even want a separate views file.  Ruby
has a way of embedding data at the end of a file, which Sinatra makes use of to
embed templates directly into its file.

    get '/' do
      haml :index
    end

    enable :inline_templates

    __END__

    @@ layout
    %html
    = yield

    @@ index
    %div.title Hello world!!!!!
    
NOTE: Inline templates defined in the source file that requires sinatra are
automatically loaded. Call `enable :inline_templates` explicitly if you
have inline templates in other source files.

### Named Templates

Templates may also be defined using the top-level `template` method:

    template :layout do
      "%html\n  =yield\n"
    end

    template :index do
      '%div.title Hello World!'
    end

    get '/' do
      haml :index
    end

If a template named "layout" exists, it will be used each time a template
is rendered. You can disable layouts by passing `:layout => false`.

    get '/' do
      haml :index, :layout => !request.xhr?
    end

Partials
--------

Partials are not built into the default installation of Sinatra.

The minimalist implementation of partials takes zero helper code.  Just call
your view method from your view code.

    <%= erb :_my_partial_file, :layout => false %>

You can even pass local variables via this approach.

    <%= erb :_my_partial_file, :layout => false, :locals => {:a => 1} %>

If you find that you need a more advanced partials implementation that handles
collections and other features, you will need to implement a helper that does
that work.

    helpers do
      def partial(template, options={})
        erb template, options.merge(:layout => false)
        #TODO: Implementation
      end
    end
    
### Accessing Variables in Templates

Templates are evaluated within the same context as route handlers. Instance
variables set in route handlers are direcly accessible by templates:

    get '/:id' do
      @foo = Foo.find(params[:id])
      haml '%h1= @foo.name'
    end

Or, specify an explicit Hash of local variables:

    get '/:id' do
      foo = Foo.find(params[:id])
      haml '%h1= foo.name', :locals => { :foo => foo }
    end

This is typically used when rendering templates as partials from within
other templates.
