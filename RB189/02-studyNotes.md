# RB189 Study Notes

## Required Skills
- write a Ruby application using Sinatra
- write ERB code to display application in browser
- create Gemfile and Gemfile.lock to install app on another system
- provide SQL to create / seed database for app
- zip project into a file

## Study topics

### Writing Sinatra applications

#### Basic 'skeleton'
- non-sinatra apps:  'config.ru' will contain `run App.new` (if application is in 'App' class and can be run through `#initialize`)
- Sinatra app: 'config.ru' will contain `run Sinatra::Application` (application is referenced through the `require 'app.rb'` and NOT in a class, but includes a `require 'sinatra'` statement)
- run the application using `bundle exec rackup config.ru`; optional `-p 9595` to specify a port
- `Gemfile`:
  ```ruby
  source 'https://rubygems.org'

  ruby '2.5.5'
  gem 'sinatra', '1.4.7'
  gem 'sinatra-contrib'
  gem 'erubis', '2.7.0'
  ```
- `config.ru`:
  ```ruby
  require_relative 'app.rb'
  run Sinatra::Application
  ```
- `app.rb`:
  ```ruby
  require 'sinatra'
  require 'sinatra/reloader'
  require 'tilt/erubis'

  get '/' do
    erb :home, layout: :post # note layout argument is optional, will default to using 'layout.erb' if not provided
  end
  ```
- `./views/layout.erb`
  ```html
  <!DOCTYPE html>
  <html lang='en'>
  <head>
    <title></title>
    <meta charset='utf-8'>
    <link rel='stylesheet' href=''>
  </head>

  <body>
    <%= yield %>
  </body>
  </html>
  ```
- `before` blocks are run before each route is executed (including before redirected routes are executed)

- `Sinatra::ContentFor` module - is part of `sinatra-contrib`
  `require 'sinatra/content_for'`
  ```html
  <!-- in 1 file -->
  <% content_for :some_key do %>
    <chunk> html </chunk>
  <% end %>

  <!-- in another file -->
  <%= yield_content :some_key %>
  ```

- escape all HTML:
  - include in configure block: `set :erb, :escape_html => true`
  - use `<%== %>` : e.g., `<%== yield %>` when including html output to disable auto-escaping


#### Headers
- e.g., `headers['Content-Type'] = 'text/html'` or `headers['Content-Type'] = 'text/plain'`
  - can be modified directly within a route; e.g., can be used to display html vs plain text


#### XML (sinatra)
- don't forget that Sinatra has an `env` hash which contains all of the various headers, etc. from received HTTP requests
  - e.g., can check `env['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest` : will find XML HTTP requests
  - Note: browser will not display re-directed pages when that re-direct is the result of an XML request
- can send a custom status code response (e.g., to an XML request) using e.g., `status 204` : sends a 204 response

#### pg
- `logger` is a built-in Sinatra helper - is used to log routes and can be used to log additional info (e.g., from SQL queries)

### Writing ERB code
- 'ERB' : 'Embedded RuBy' into HTML
- `<%= %>` : evaluate embedded ruby and include return value in HTML output
- `<% %>` : evaluate embedded ruby and do NOT include return value in HTML output
- `params` can refer to either user-input or URL input - can be ambiguous
  - using instance variables (e.g., `@list_name`) explicitly can make it clear which values are defined by program (in route) vs user
- including `<meta charset='utf-8'>` may be helpful with testing results to ensure that the html responses are rendered correctly and the Minitest interprets those responses appropriately (defining `headers['Content-Type'] = "text/html;charset=utf-8"` is not sufficient)


### Using view variables and helpers
- helpers:  include a `helpers do ... end` block which contains methods specifically for views
  - view helpers can be used for applying conditional css classes to html tags (i.e., the output of a view helper will be a string - blank OR of desired css classes)
  - use helpers to keep and 'business logic', calculations, etc. OUT of the views - this makes the views more flexible and keeps the intent in the view templates simple
  - can show lists in sorted order, maintaining same index as array, with view helper:
    - create view helper to store a hash of items as key, index as value - in the new order; also take a block
    - iterate through that hash in order and yield the item and index to the block (which was part of the view)

- view variables are instance variables (e.g., `@title`) which are defined in the route and automatically passed to the template


### Using and writing routes
- use URL path (route) and/or params to provide input to the program
  - 1) `http://localhost:3003/?rolls=2&sides=6` could be equivalent to 2) `http://localhost:3003/rolls/2/sides/6`
    - 2) sides is nested under rolls: might imply that there's a dependent relationship between sides and rolls
- generally, routes are named in a way that includes the type of object being accessed / modified:
  - e.g., `/lists`, `/lists/1`, `/lists/new`, `/users`, `/users/1`, etc.
- 'GET' is for retrieving information
- 'POST' is for changing information on the server (e.g., updating, deleting, etc.)
  - need to use a FORM to submit POST requests


### Sessions and persistence
- Sinata provides a session object to store info, needs to be configured:
  ```ruby
  configure do
    enable :sessions
    set :session_secret, 'secret'
  end
  ```
  - can then access `session` - a hash; new key-value pairs can be defined, as desired (e.g., `session[:lists] or session[:message]`)
  - note: `session_secret` shouldn't be hard-coded in a production app - it should be stored in an environment variable so it isn't visible in the source-code
    - if a session secret isn't defined, then Sinatra creates a random session secret every time - means data cannot be persisted between different uses of the app


### Using / optmizing SQL queries
- 'adapter pattern' - consolidating all elements associated with interacting w/ database into 1 class (e.g., 'DatabasePersistence') and defining common methods on that class that have interface inheritance with other classes that can interact with different databases or persistence methods (e.g., sessions, or yaml)
- be consistent with WHERE type-casting takes place when creating DatabasePersistence or SessionPersistence classes
  - i.e., pattern from todos project is to have all casting done OUTSIDE the DatabasePersistence class so that only proper ruby values are passed INTO the class and can be used directly
- use 'pg' gem
- best to be as specific as possible when deleting info from database (i.e,. use more than 1 field to identify a data row)
  - e.g., using both 'list_id' and 'todo_id' to confirm the correct entry in a table is deleted

- avoid 'N+1' queries if possible
  - i.e., to load a single page with N elements on it requires N + 1 db queries (1 query for a list of elements, N queries for details associated with each element)
  - generally doing less db queries is better for performance (especially with many users, many queries)

- generally, optimize queries AFTER determining that optimizations are required
- always include an `ORDER BY` clause to ensure results from db are in a consistent order, otherwise db may return in an unexpected order

- db is generally faster for doing counts:
  - to do a count in ruby, would need to return ALL data and then do the count - if only the count is required, there's no reason to return ALL of the data (especially if there is a significant amount of data)

- it may make sense to separate data into different instance variables (and thus separate queries) to ensure that only the information needed is queried from the database (e.g., todos vs lists - these can naturally be part of separate instance variables in the app / views)



### Validation / flash messages
- easiest way is to use store the message in a session (e.g., `session[:message]`) and delete that message once displayed (so it doesn't re-appear when page is reloaded)
  - e.g., could use `session.delete(:message)` : will delete the message, but also returns the value of the message being deleted so that it can be displayed


### Using static assets
- includes stylesheets (css), js, icons, images (anything in the '<head>' section of html)
- these go into the 'public' folder (and should be available to be served by webserver directly)
  - e.g., for A2hosting deployment, these files need to be moved to ~/public_html/[app path name]


### Working with request/response cycle
- valid response needs a status code, required headers (optional), message body (optional)
  - can use html tags to indicate that whitespace should be preserved in output: `<pre></pre>`
- note: browsers can make requests even if the user does not - need to ensure program can address 'empty' requests (e.g., in simple TCP server using 'socket')
- should always write code to manage failed requests from back-end (e.g., http status code 500, etc)
  - example projects only wrote code for successful responses, but failed responses are common for many reasons
- status code '204' : success, but no content will be sent (e.g., a good response for XMLHttpRequests)


### Know when to use GET / POST correctly
- pages that only retrieve information use 'GET'
- pages that change info on server use 'POST' (and require a form in ERB template, not just an `<a>` tag)
  - 'action' is the link/route required; `method='post'`
- best to use 'POST' for deleting data (don't use 'GET')
- Note: HTML forms can only create 'GET' or 'POST' requests when they are submitted
  - to create other requests (e.g., 'DELETE'), must use javascript / XML requests


### Using redirects properly
- `redirect` (built-in method) uses the 'Location' header in the response to re-direct the browser to a new URL
- general pattern:
  - redirect when something happens successfully
  - render a page when an error occurs (will save the data entered and allow the user to fix the error and re-submit)
    - note that if there's an error, the URL (route / path) will not change
    - use route params to re-display data the user may have previously entered (and was submitted to 'post' route)
      - e.g., `<input value = "<%= params[:list_name] || @list[:name] %>` : `params[:list_name]` contains user-submitted (incorrect) info, @list[:name] contains existing value, if page is being loaded for the first time


### Maintaining state
- need to persist data:
  - could use 'sessions' (cookies), files (e.g., yaml), db (e.g., postgresql)
- be careful with 'toggle' functionality (for booleans) : don't rely on information that is subject to change
  - i.e., don't assume that data the client sees is the same as the data on the server
  - i.e., in a distributed application, just toggling may result in an unexpected final value - request may be submitted twice, someone else may change in advance, etc.
  - setting an explicit desired value to change to is better (i.e., set as `true` or `false` and not just `!current`)


### Understand and know how to mitigate security risks that can affect HTTP and SQL

#### HTTP
- `session-secret` : should be stored in an environment variable so it's not part of (visible in) source-code
  - can use `SecureRandom.hex(32)` to generate a 'session secret'
- error messages:  don't reveal too much about program architecture, etc - could be misused by a malicious user
- always escape user input (from forms, etc) to prevent JS injection
  - can use `Rack::Utils.escape_html` (Rack library for escaping HTML) : best to write a view helper to sanitize any user input that might be written to page
  - alternative is to do it for all html:
    ```ruby
    configure do
      set :erb, :escape_html => true
    end
    # use <%== %> in view templates to prevent auto-escaping and display templates / content_for
    ```
- always include a `not_found` path in sinatra to prevent error messages - can indicate valuable system information
- Note:  'POST' is really **no more** secure than 'GET' - although the information isn't obviously displayed on-screen, it's still plain text within the HTTP request body;  need to use HTTPS to encrypt the text-based requests/responses being sent out over the internet
- when storing passwords, always use salted hashes - never store passwords in plain-text
  - in ruby:  use the gem 'bcrypt' to store pw hashes and compare with user input
- (from CMS app) : avoid providing filenames as parameters - this lets a user manipulate the filename, potentially exposing source code or other sensitive details on the file system
  - If you must, can use `File.basename(user_entry)` to strip anything other than filename or extension
- **allow-listing** : explicitly list the things users are *allowed* to do (e.g., only access '.txt' and '.md' files - create specific 'case' or 'if' statements to allow this and don't use 'else' statements broadly)
- consider the risk posed by any user input (like parameters)

#### SQL
- use `PG#exec_params` to prevent injecting additional SQL queries through string interpolated user-inputted values
  - any user input should be incorporated with `exec_params`
  - internal SQL queries can use `PG#exec`


## Misc

### Echo server
- Simple echo server [^1]
  ```ruby
  require 'socket'
  server = TCPServer.new('localhost', 3003)
  loop do
    client = server.accept

    request_line = client.gets
    puts request_line

    client.puts 'HTTP/1.1 200 OK' # status line
    client.puts "Content-Type: text/plain\r\n\r\n" # optional headers, w/ required blank line b/w body
    client.puts request_line # message body
    client.close
  end
  ```
  - creates a simple server at localhost:3003, echos the HTTP request line


### Rack
- Rack interfaces [^2]
  - **Ruby application** (e.g., ruby file, sinatra app) : makes server-side changes, handles business logic, generates dynamic content
  - sends/receives HTTP request/response to/from [using RACK interface]
  - **Application server** (e.g., WEBrick, Puma, Thin, Passenger) : runs application, stores application in memory
  - sends/receives HTTP request/response to
  - **Web server** (e.g., Apache, Nginx) : receives request from clients, handles incoming requests concurrently, serves static files
  - sends/receives HTTP request/response to
  - **Client** (e.g., browser)
- Rack takes plain-text HTTP and forms Ruby objects for use by Ruby program [^2]
  - app must have `def call(env)` and returns an array: `[status, headers, [body]]` (body doesn't need to be an array, just needs to respond to 'each' method) [^4]
    - (e.g., `['200', {'Content-Type' => 'text/plain'}, ['hello world!']]`)
  - can run Rack applications using 'config.ru' file
    - OR
      ```ruby
      require 'rack'
      class MyApp
        def call(env)
          ['200', {'Content-Type' => 'text/plain'}, ['hello world!']]
        end
      end
      Rack::Handler::WEBrick.run MyApp.new
      ```
    - note `env` (from rack) is different and unrelated to `ENV` (from ruby/OS environment) [ENV](https://ruby-doc.org/core-2.7.0/ENV.html)

- Rack 'Middleware' [^3]
  - needs to adhere to 'rack standard' - i.e., include a 'call' method and return [status, headers, body]
  - can be used to complete actions prior to invoking the main 'app' AND/OR modify output from main 'app'
  - can be invoked directly in ruby file: e.g., `Rack::Handler::WEBrick.run Wave.new(FriendlyGreeting.new(MyApp.new))`
  - OR using `config.ru`:
    ```ruby
    require_relative 'myapp'
    use Wave
    use FriendlyGreeting
    run MyApp.new
    ```
    - note order is preserved -  last listed takes output from main app and then it's output is passed up the chain to middleware listed above


### File listing in a directory
- can use `Dir.glob('*')` : returns array of files in current working directory
- can use `File` class to manipulate paths and files
  - e.g., `File.basename(file)`
- `File.expand_path('..', __FILE__)` is the 'idiomatic' (widely accepted) standard for listing files in the current working directory of an executed ruby file
  - this means "expand current executed file name to a full path, then go 1 level up";  `__FILE__` is an 'absolute' name (i.e., it doesn't matter where you call the project file from)
  - where there are symlinked directories (e.g., `ln -s scratch xyzzy` links the existing scratch directory with an alias 'xyzzy'), if the ruby code in 'scratch' is executed using 'xyzzy' (i.e., `ruby xyzzy/test.rb`):
    - 1) using `File.expand_path('..', __FILE__)` will return the 'aliased' folder used to execute the ruby file (i.e., 'xyzzy')
    - 2) using `File.expand_path(__dir__)` will return the actual folder (i.e., 'scratch') where the executed ruby file is located
    - be aware of this difference b/w/ use of 1) and 2)
    - generally 1) is more accepted, even if Ruby community prefers 2) (i.e., rubocop rule)

- BEST SOLUTION to return a list of all files (basename only) in 'data' directory:
  ```ruby
  root = File.expand_path('..', __FILE__)
  Dir.glob(root + '/data/*').map { |full_path| File.basename(full_path) }
  ```
- best to use `File.join` to join path segments together
  - OS X and Linux use `/`;  Windows uses `\`


### Input validations
- Only validate (and provide suitable error messages) when:
  - it's an error that the user might create (i.e., should expect this)
  - it's 'recoverable' - i.e., the user can fix it (i.e., bad input)
- otherwise, it's a bug, and should be left to be handled as a bug (trying to handle it will complicate the code)
- error messages:
  - be wary of error messages that tell a malicious user too much information


### Custom checkboxes
- see CSS for todo application - actually uses `:before` and image file to display a custom graphic for a hidden checkbox input
  - a new custom graphic (displaying a 'checked' view) is displayed when the underlying data value is 'checked' (based on conditionally assigning a class)


### Adding Tests
- see updated RB185/01skeleton
  ```ruby
  # add to Gemfile
  gem 'minitest', '5.10.3'
  gem 'rack-test', '2.1.0'

  # in app_test.rb
  ENV['RACK_ENV'] = 'test'

  require 'minitest/autorun'
  require 'rack/test'
  require_relative '../app.rb'

  class AppTest < Minitest::Test
    include Rack::Test::Methods

    def app
      Sinatra::Application
    end

    def test_index
      get '/'
      assert_equal 200, last_response.status
      assert_includes 'Sinatra App', last_response.body
    end

    def test_add_session_keyvalues
      # first hash is parameters, second hash is values to be added to Rack.env hash
      get '/', {}, {'rack.session' => { username: 'admin' } }
    end
  end
  ```
- Note different status codes for re-direction b/w Sinatra and Rack::Test
  - Rack::Test : will send a 302 for redirection for both GET and POST
  - Sinatra : will send 303 for redirection from POST; 302 for redirection from GET
- To access session cookies, need to use `last_request.env['rack.session']`
  - can define a method to shorten syntax:
    ```ruby
    def session
      last_request.env['rack.session']
    end
    ```


# References
[^1] [A Simple Echo Server](https://launchschool.com/lessons/cac53b94/assignments/a32ebc5e)
[^2] [Rack Pt 1](https://aumi9292.medium.com/rack-part-i-6bb268dde211)
[^3] [Rack Pt 2](https://aumi9292.medium.com/rack-part-ii-5dc89e9d89d8)
[^4] [Growing your own web framework with Rack](https://launchschool.medium.com/growing-your-own-web-framework-with-rack-part-1-8c4c630c5faf)



# Assessment Prep
- [ ] 1 quick db-backed application from scratch : a notes application that takes 
      - [ ] incorporate login / pw's / bcrypt
- [ ] convert timers to db-backed; add tests
- [ ] practice with at least 1 of each CRUD
