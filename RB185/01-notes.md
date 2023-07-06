# RB185 Initial Notes

## Connecting to PostgreSQL w/ Ruby (pg)
- use 'pg' gem
- `require 'pg'` [^1]
  - e.g., `db = PG.connect(dbname: 'rb185')` : establishes connection with db
  - e.g., `db.exec "SELECT 1;"` : executes an SQL query, will return a result object
    - Note: the `;` is optional
    - Best practice: only execute 1 SQL statement per `.exec` call (i.e., don't combine sql statements and separate them with a `;`)
  - e.g., `result = db.exec "SELECT 1;"` : assigns the result object to a var
    - using pry: can do `cd result`, then `ls` to see methods available on the result object OR `ls result`
      - e.g., `show-method result.fields` : if 'show-method' is installed, will display documentation on `#fields` method
      - e.g., `show-doc result.fields` : if documentation is available, can show that instead
    - `result.values` : lists the values returned by a query (array of arrays)
    - `result.fields` : lists headers in query result
    - `result.values.size` : lists number rows returned (incl. header)
    - `result.ntuples` : also lists number of rows returned (incl. header)
    - e.g., `result.each { |tuple| puts "#{tuple['title']} came out in #{tuple['year']}" }
    - e.g., `result.each_row { |row| puts "#{row[1]} came out in #{row[2]}" }
    - e.g., `result[2]` : returns a hash of the 3rd row
    - e.g., `result.field_values('duration')` : returns an array where the values for column 'duration' are all returned as elements in an array
    - e.g., `result.column_values(4)` : similar to 'field_values', but requires a column index number
    - Note: 'tuple' is a Ruby hash (not an SQL 'tuple'), 'row' refers to an array with each element a value in that row
  - e.g., `result = db.exec_params("INSERT INTO table (amount, memo) VALUES ($1, $2::text), [value1, value2])` : better than using `#exec` - using parameters will help to manage SQL injection attacks [^3]


## Creating command line programs with Ruby [^2]
- script file does not need an extension (e.g., `expense` is sufficient)
- put `#! /usr/bin/env ruby` as the first line (indicates that ruby should be used to run the rest of the script file)
- `chmod +x ruby_file_name` : to make it executable
- `ARGV`: an array of the command line arguments passed in when ruby is invoked
- when getting user input, need to define `$stdin` explicitly, otherwise, it's not possible to use 'gets' or 'getch' [^4]
  - using gets:  `input = $stdin.gets.chomp`
    - if ARGV has arguments in it, then `Kernel#gets` will treat the first argument as a file and try to read from it, hence the error `in 'gets': No such file or directory @ rb_sysopen - [argument value]`
    - if we use ARGV.shift to remove the first argument, leaving an empty ARGV array, then the standard 'gets' will work without defining `$stdin`

  - using getch:
    ```ruby
    require 'io/console'
    input = STDIN.getch
    ```
- `SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'table_to_lookup';`
  - this will return `1` if a table named 'table_to_lookup' exists; `0` otherwise [^6]

## Web application architecture
- **adapter pattern** [^7]
  - implementing separate classes (with common methods) to interact with different data stores (e.g., session cookies, postgresql db, etc.)
  - browser <-- HTTP request / response --> Sinatra Application (handles incoming requests)
  - Sinatra Application <-- Method Calls --> Store Adapter (e.g., for cookies, or Postgresql)
  - Store Adapter <-- queries / response --> Database (e.g., actual cookie or db)
- helpful to be consistent with where to deal with types [^8]
  - e.g., route types are all strings, but inside "SessionPersistence" class, assume all types are as desired
    - i.e., deal with changing types, etc. outside of SessionPersistence class and pass in correct types
  - being consistent is helpful for later adding a db

- use of built-in Sinatra logging functionality [^9]
  - 'logger' : built-in Sinatra logging object
  - `logger.info "string to log"` : add "string to log" (can be interpolated with variables) to an instance of logging info - included in terminal output
  - to log all debugging info (e.g., from db) to the same place as other Sinatra log info
  - 


# References
[^1]: [Executing SQL Statements from Ruby](https://launchschool.com/lessons/10f7102d/assignments/003e5e30)
[^2]: [Project Setup](https://launchschool.com/lessons/10f7102d/assignments/2090528a)
[^3]: [Handling Parameters Safely](https://launchschool.com/lessons/10f7102d/assignments/6877d345)
[^4]: [Clearing Expenses](https://launchschool.com/lessons/10f7102d/assignments/78571424)
[^5]: [Forum question on gets/getch](https://launchschool.com/posts/d0c47b25)
[^6]: [Creating the Schema Automatically](https://launchschool.com/lessons/10f7102d/assignments/99b9d97f)
[^7]: [Project Overview](https://launchschool.com/lessons/421e2d1e/assignments/e8c01dbf)
[^8]: [Extracting Session Manipulation Code](https://launchschool.com/lessons/421e2d1e/assignments/0ff36959)
[^9]: [Executing and Logging Database Queries](https://launchschool.com/lessons/421e2d1e/assignments/d7a23509)