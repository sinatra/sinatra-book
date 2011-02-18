Filters
=======

Overview
--------

Before filters are run before or after the route has been processed:

    before do
      MyStore.connect unless MyStore.connected?
    end
    
    get '/' do
      @list = MyStore.load_list
      haml :index
    end

Similar to before filters, after filters are run after the request has been
processed:

    after do
      MyStore.disconnect
    end

It is also possible to have multiple filters:

    before { do_something }
    before { something_else }
    
    get '/' do
      # ...
    end
    
    after do
      do_something
    end
    
    after do
      something_else
    end

Filter context
--------------

Filters are run in the same context as routes, and can therefore access all instance variables and helper methods:

    helpers do
      attr_reader :current_user
      def user(id) User.find(id) end
    end
    
    before { @current_user = user session['user_id'] }
    
    get '/admin' do
      pass unless current_user.admin?
      erb :"admin/index"
    end

Changing the response
---------------------

The return value of a filter is ignored, therefore a request to '/' will return 'yes' for the following Sinatra application:

    get('/') { 'yes' }
    after { 'no' }

However, it is possible to change the response using `halt`:

    get('/') { return @business_secrets }
    after { halt 403, 'you almost got me' }

Pattern matching filters
------------------------

Filters optionally taking a pattern, causing them to be evaluated only if the request path matches that pattern:

    before '/protected/*' do
      authenticate!
    end
  
    after '/create/:slug' do |slug|
      session[:last_slug] = slug
    end

