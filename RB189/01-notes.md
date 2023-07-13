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
    - Note: 'exec_params' params (e.g., $1, $2) can only be used as substitutes for values, but not for identifiers [^11]
      - can use 'string interpolation' or can use `quote_ident`. e.g.:
        ```ruby
        table_name = db.quote_ident(table_name)
        query_result = db.exec("SELECT * FROM #{table_name}")
        ```


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

- when refactoring [^10]
    - when changing an object and getting an error:
        - can try just adding the required hash keys with defined values to see if it helps resolve enough errors to display the page,
        - then go back and define the right values
    - always best to have the same representation of objects in the code (i.e, the same keys / values, as required) to prevent errors
    - don't be afraid to duplicate code:
        - first duplicate code to get (tests) to work
        - THEN - must go back to remove duplication to have clean code

## DB vs application
- when to push operations down to db [^10]
  - when counting - more efficient for db (don't need to pass ALL data to application in order to count)
  - only include the data required in each hash (e.g., separate todos info from list hash)

## Lessons learned from adding db in personal project
- Use of a custom class to store data created an extra step when pulling from and pushing to db (i.e., had to convert to and from the custom class)
- use of the custom class to manage qty (e.g., `Item#use`) meant that both the data store and the session managed adding/removing items - I didn't create a 'clean' (consistent) interface;  need to be consistent in future
- in yml: easy to just write everything stored in ruby objects (e.g., source of truth was ruby objects)
  - i.e., `item#[some method]` to alter entire object, then `PersistYML#write_list` to write everything (incl. changes)
- in db: db needs to be source of truth - need to manage the 'diff' - i.e., what's been changed and push just that change to db (doesn't make sense to just write the entire object back to db)
- naming of classes, variables, fields - I use 'list' in the app, but 'inventory' in the object : big potential to be confusing;  should be consistent between app / class / objects / db
- once custom class objects have been created they 'carry' the methods created in them, no need to 'require' the class file
  - i.e., persist_yml.rb can invoke the custom class methods on 'Inventory' and 'Item' class objects without needing `require 'inventory'` or `require 'item'` statements
  - NOTE:  this example might be working since the test suite REQUIRES app.rb which requires item / inventory - as long as the required definition is included SOMEWHERE, then the code will work








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
[^10]: [Pushing Down Operations to the Database](https://launchschool.com/lessons/ce10b313/assignments/bb9d2366)
[^11]: [A special case with exec_params...](https://launchschool.com/posts/f6d8afa3)

# To-dos
- [X] look into deploying a postgresql db online (a2hosting)
- [ ] convert inventory program to use db (w/ queries, etc.)
    - [X] decide on db schema
    - [X] create persist_yml class
      - [X] confirm tests work for persist_yml class
    - [X] update persist_yml / app to allow 'replace-ability' with persist_pg (update existing inv/items)

    - [X] create persist_pg class
    - [X] implement persist_pg class in app.rb
      - [ ] confirm tests work for persist_pg class
- [ ] create study notes for RB189 based on study guide
- [ ] create simple db web apps from scratch to review / apply study guide concepts