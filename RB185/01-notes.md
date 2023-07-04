# RB185 Initial Notes

## Connecting to PostgreSQL w/ Ruby (pg)
- use 'pg' gem
- `require 'pg'` [^1]
  - e.g., `db = PG.connect(dbname: 'rb185')` : establishes connection with db
  - e.g., `db.exec "SELECT 1;"` : executes an SQL query, will return a result object
    - Note: the `;` is optional
    - Best practice: only execute 1 SQL statement per `.exec` call (i.e., don't combine sql statements and separate them with a `;`
  - e.g., `result = db.exec "SELECT 1;"` : assigns the result object to a var
    - using pry: can do `cd result`, then `ls` to see methods available on the result object OR `ls result`
      - e.g., `show-method result.fields` : if 'show-method' is installed, will display documentation on `#fields` method
      - e.g., `show-doc result.fields` : if documentation is available, can show that instead
    - `result.values` : lists the values returned by a query (array of arrays)
    - `result.fields` : lists headers in query result
    - `result.values.size` : lists number rows returned (incl. header)
    - `result.ntuples` : also lists number of rows returned (incl. header)
    - e.g., `result.each { |tuple| puts "#{tuple['title'} came out in #{tuple['year']}" }
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

# References
[^1]: [Executing SQL Statements from Ruby](https://launchschool.com/lessons/10f7102d/assignments/003e5e30)
[^2]: [Project Setup](https://launchschool.com/lessons/10f7102d/assignments/2090528a)
[^3]: [Handling Parameters Safely](https://launchschool.com/lessons/10f7102d/assignments/6877d345)
