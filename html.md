# HTML notes

## In Sinatra / Rack
- escaping HTML characters:
  - can use `Rack::Utils.escape_html` method 
    - e.g., `Rack::Utils.escape_html "<script >alert("Injected code");"`

- in Sinatra:
```ruby
configure do
  enable :sessions # create session object to store info in cookies
  set :session_secret, 'this/is/secret' # encrypt session info in cookie
  set :erb, :escape_html => true # always escape html, need to use "<%== var %> in erb
end
```

- searching routes and validate that id entries exist:
  - create helper methods that return a valid entry or halt searching
  - example (Ruby) code at: https://web.archive.org/web/20221024084949/http://myronmars.to/n/dev-blog/2012/01/why-sinatras-halt-is-awesome

- use ruby gem 'bcrypt' to hash passwords when storing them and when comparing them against user inputted pw's to authenticate
  ```ruby
  require 'bcrypt' # after install the gem, include in Gemfile

  hashed_pw = BCrypt::Password.new('pw entered') # creates a hash w/ salt
  hashed_pw == 'pw entered' # returns true
  ```

- using environment variables to define different directories for test vs prod:
  ```ruby
  def data_path
    if ENV['RACK_ENV'] == 'test'
      File.expand_path('../test/data', __FILE__)
    else
      File.expand_path('../data', __FILE__)
    end
  end

  def get_filepath(file)
    File.join(data_path, file)
  end
  ```

- list files in a directory:
  ```ruby
  pattern = File.join(data_path, "*") # uses 'data_path' above, "*" for all files
  @files = Dir.glob(pattern).map do |path|
    File.basename(path)
  end
  ```

- sinatra - set status and headers:
  ```ruby
  status 422
  headers['Content-Type'] = 'text/html' # or 'text/plain'
  ```

- sinatra, display notification messages on screen
  - in view template (erb):
  - delete messages as soon as they are displayed (#delete returns the item to be deleted)
  ```html
  <% if session[:message] %>
    <div class="flash_message">
      <p><%= session.delete(:message) %></p>
    </div>
  <% end %>
  ```

- yaml files:
  - stored as text files, e.g.:
  ```yaml
  ---
  - :name: list1
    :items:
    - pizza
    - doritos
    - apples
  ```
  - once read into program, saved as objects / arrays, e.g.:
  ```ruby
  [
    {
      name: 'list1',
      items: ['pizza', 'doritos', 'apples']
    }
  ]
  ```
  - code:
  ```ruby
  require 'yaml'
  
  var = Psych.load_file('data.yaml')

  File.write('output.yml', Psych.dump(var))
  ```

- testing sinatra files:
```ruby
ENV['RACK_ENV'] = 'test' # to sent environment variables

require 'minitest/autorun'
require 'rack/test' # to test routes, etc.
require 'fileutils' # to access shell commands via fileutils

class CMSTest < Minitest::Test
  include Rack::Test::Methods # required for route testing

  def app
    Sinatra::Application
  end

  def create_document(name, content='') # useful for creating required files for each test
    File.open(File.join(data_path, name), 'w') do |file|
      file.write(content)
    end
  end

  def session # useful for accessing session hash
    last_request.env['rack.session'] # note last_request vs last_response
  end

  def admin_session # shortcut for setting session variables (e.g., authenticating a user)
    { "rack.session" => {username: "admin"} }
  end

  def setup # create a test files directory (for each test - to make them independent)
    FileUtils.mkdir_p(data_path)
  end

  def teardown # remove created test files directory (for each test)
    FileUtils.rm_rf(data_path)
  end

  def test_index # example test - files are created, outcome is asserted
    create_document('about.md')
    create_document('changes.txt')

    get '/'
    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_match /about.md/, last_response.body
    assert_match /changes.txt/, last_response.body
  end

  def test_no_file
    get '/notafile.ha'
    assert_equal 302, last_response.status
    assert_equal 'notafile.ha does not exist.', session[:message] # tests session[:message] directly

    get last_response['Location'] # will 'redirect' to defined location (browsers do this automatically, test suite needs to do it manually)
    assert_match /notafile.ha does not exist./, last_response.body
  end

  def test_edit_page_admin
    create_document('changes.txt', 'Start of changes:')
    
    get '/changes.txt/edit', {}, admin_session # create an authenticated session by setting session variables
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Edit content of changes.txt:'
  end

  def test_edit_post_admin
    create_document('changes.txt', 'Start of changes:')
    content = File.read(get_filepath('changes.txt'))

    post '/changes.txt', {text_area: content + "\ntest content\n"}, admin_session # authenticated session & other params
    # routes can take 2 additional parameters: a list of parameters and then a list of environment variables (both are hashes)
    assert_equal 302, last_response.status # sinatra always returns 302 for testing, not 303 like browser
    assert_equal 'changes.txt has been updated.', session[:message] # tests session[:message] directly
  end

  def test_invalid_credentials
    post '/users/signin', username: 'james', pw: 'pizzad'
    assert_equal 422, last_response.status
    assert_includes last_response.body, 'Invalid credentials'
  end
end
```

- Sinatra:  from within a route, access the application environment settings using `env` or `request.env` (`env` is like an alias for `request.env`)
  - `ENV` returns the environment variables for the *local system's* shell (terminal)

