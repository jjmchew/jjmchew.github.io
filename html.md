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
