Models
======

DataMapper
----------

Start out by getting the DataMapper gem if you don't already have it, and then
making sure it's in your application. A call to `setup` as usual will get the
show started, and this example will include a 'Post' model.

    require 'rubygems'
    require 'sinatra'
    require 'data_mapper' # metagem, requires common plugins too.

    # need install dm-sqlite-adapter
    DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

    class Post
        include DataMapper::Resource
        property :id, Serial
        property :title, String
        property :body, Text
        property :created_at, DateTime
    end

    # Perform basic sanity checks and initialize all relationships
    # Call this when you've defined all your models
    DataMapper.finalize

    # automatically create the post table
    Post.auto_upgrade!

Once that is all well and good, you can actually start developing your
application!

    get '/' do
        # get the latest 20 posts
        @posts = Post.all(:order => [ :id.desc ], :limit => 20)
        erb :index
    end

Finally, the view at `./view/index.html`:

    <% @posts.each do |post| %>
        <h3><%= post.title %></h3>
        <p><%= post.body %></p>
    <% end %>

For more information on DataMapper, check out the [project
documentation](http://datamapper.org/docs/ "DataMapper").
