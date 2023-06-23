# PostgreSQL

## documentation:
- notes from video[^12]
- make sure to find your version (indicated when you start `psql` from command line)
- easiest to search command (e.g., 'select')
- e.g., https://www.postgresql.org/docs/12/sql-select.html
  - `[]` : indicates optional elements
  - `{}` : indicates options
  - ***terms*** : (bold and italic) indicate more details below - scroll through the page to find


## theory:
  - SQL (Structured Query Language) : is a 'special purpose language' - has a specific purpose for interacting with relational databases [^15]
    - a declarative language : only details *what* to do, not *how* - 'under-the-hood' SQL may execute things differently depending on the dataset
  - RDBMS (Relational Database Management System) : a software application that lets you issue commands and interact with a relational database (uses syntax that conforms to a set of conventions or standards) [^14]
  - Relational Database : a database organized according to the relational model of data - defines a set of relations (or tables) and describes relationships between them [^14]
  - data vs schema: [^1]
    - data is 'contents' of the database
    - schema is 'structure' of the database
    - combining data and schema gives us *structured data* - otherwise, if all of the data wasn't assigned to a schema, it would be *unstructured data*
  - SQL sub-language deals with different parts of database: [^2]
    - **DDL** : Data Definition Language - define structure of database and tables / columns within it
    - **DML** : Data Manipulation Language - retrieve or modify data stored in database (e.g., queries, `SELECT`, etc.)
    - **DCL** : Data Control Language - define what users are allowed to do when interacting with database
  - database analogy: [^3]
    - database : building
    - floor plan : schema
    - rooms : tables
  - database names are generally written in snake_case [^3]

- CRUD: [^5]
  - structure (schema) is in columns, data is in rows (sometimes called 'tuples')
  - each "row" is a record - an individual entity

- SQL escapes `'` using `'` e.g., `'O''Leary'` is the string `O'Leary` [^5]
- Generally - should set 'boolean' columns to 'NOT NULL', otherwise SQL will allow NULL values [^5]
- identifiers vs keywords: [^6]
  - identifiers : identify tables, columns, etc.
  - keywords : indicate what to *do* (e.g., `SELECT` or `FROM`)
  - generally best not to name an identifier after a keyword (if you do, use `""` to indicate identifiers, e.g., "year")
- when using `AND` and `OR` - `AND` has higher precedence than `OR` - best to use `()` to ensure desired groupings are applied [^6]

- acceptable boolean values in PostgreSQL: [^9]
  - true: `'t'`, `'true'` `'y'`, `'yes'`, `'on'`, `'1'`, `true`
  - false: `'f'`, `'false'`, `'n'`, `'no'`, `'off'`, `'0'`, `false`

- database *normalization*: [^10]
  - the act of splitting up data across multiple different tables and creating relationships between these tables
    - to reduce data redundancy and improve data integrity
    - using 'normal forms' (sets of rules which define when a database can be considered 'normalized')
  - define *entities* and *relationships*
  - entity:  a 'real world' object or set of data (e.g., 'user', 'book', 'checkout', 'reviews', 'addresses')
  - relationships:  can be mapped using an 'ERD' (*Entity Relationship Diagram* - graphical representation of entities and relationships)

- primary key: a unique identifier for a row of data [^10]
  - typically called 'id'
  - must be 'NOT NULL' and 'UNIQUE'
  - must also be specifically defined as primary key; i.e., `ALTER TABLE users ADD PRIMARY KEY (id);`
- foreign key: allow us to associate a row in one table to a row in another table (a primary key); set 1 column as foreign key and have that reference another table's primary key column [^10]

- referential integrity: the assurance that a column value within a record must reference an existing value [^10]
  - PostgreSQL will not allow you to add a value to the Foreign Key column of a table if the Primary Key column of the table it is referencing does not already contain that value
  - in relational data - table relationships must always be consistent
  - 'modality' determines why we can add a user without an address, but can't add an address without a user
  - e.g., `ON DELETE CASCADE` : deciding what to do when a row is deleted (especially when referenced by another table) is an important part of maintaining referential integrity
    

- key entity relationships: [^10]
  - one-to-one:
    - the primary key of table1 is used as the primary key and foreign key of another table
    - `CREATE TABLE another_table (id2 int, PRIMARY KEY (id2), FOREIGN KEY (id2) REFERENCES table1 (id1) ON DELETE CASCADE);` : creates a new table 'another_table' for which the primary key and foreign key reference the primary key of 'table1' which is column 'id1'
  - one-to-many:
    - if an entity instance in 1 table can be associated with multiple records (entity instances) in the other table; the opposite relationship does not exist
    - e.g., a review belongs to only 1 book; a book has many reviews
    - `CREATE TABLE reviews (id serial, book_id integer NOT NULL, PRIMARY KEY (id), FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE);` : the table 'reviews' has a primary key 'id' and also a foreign key (book_id) which references the 'id' column of the 'books' table;  note book_id is not 'UNIQUE' - hence each book can have more than 1 review
    - generally, a 'foreign key' column should not be null (e.g., 'book_id' above - a review would not exist without a book)
  - many-to-many:
    - for 1 entity instance there may be multiple records in the other table, and vice versa
    - typically implemented using a separate table (called a *join table*) which contains foreign key columns which reference the primary keys (id's) of each entity (i.e., implement 2 separate 1-to-many relationships)
    - e.g., `CREATE TABLE checkouts (id serial, user_id int NOT NULL, book_id int NOT NULL, checkout_date timestamp, return_date timestamp, PRIMARY KEY (id), FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE);` : creates a new table 'checkouts' which references the id (primary key) of the users table and the books table

- SQL style guide:  can use https://www.sqlstyle.guide/ [^17]

- Note:  it is possible to define a column default value that conflicts with a column constraint - an error will only be raised when that default is attempted to be added as data to a new record [^21]q17


## setup

### installing:
- https://launchschool.medium.com/how-to-install-postgres-for-ubuntu-linux-fa06a162348
  - `sudo apt-get update`  (update apt-get packages)
  - `sudo apt-get install postgresql postgresql-contrib libpq-dev` (install required packages)
  - `sudo -u postgres createuser --superuser $USER` (create ourselves as superuser on server with same login name)
    - I had trouble here: "error: could not connect to database template1: could not connect to server: No such file or directory"
    - https://stackoverflow.com/questions/42653690/psql-could-not-connect-to-server-no-such-file-or-directory-5432-error
      - solution ended up being using `sudo service postgresql start` to start the server first
  - `sudo -u postgres createdb $USER`
  - navigate to home directory
  - `touch .psql_history` to create a history file to save history
  - `psql`to start server (psql is a kind of 'repl' for postgres)
  - `\q` to quit server

### using:
  - `createdb`, `dropdb` are 'wrappers' around SQL commands - these are run from the terminal;  these are distinct from commands run within the `psql` console / terminal
  - `psql postgres` : start psql and connect to database `postgres` (a default db)

---



---

## Commands

### within psql console
  - `\q` : quit
  - `\conninfo` : connection info (db, user, socket, port)
  - `\list` or `\l` : list all db's created; [^13]
  - `\c [db_name]` or `\connect [db_name]` : connect to db "db_name"
  - `\e` : opens text editor with last executed command to edit
  - `\dt` : list all tables in db
  - `\ds` : list all sequences in db [^13]
  - `\d tablename` : show details of table 'tablename'
  - `\d` : describe available relations (list) [^13]
  - `\?` : list commands [^13]
  - `\h [topic]` : help; indicate topic is optional [^13]
  - `\i file_name` : import SQL commands into current db [^19]
    - e.g., `\i ~/folder/file_to_import.sql`

### from command line
  - `/usr/bin/select-editor` : changes default psql text editor for `\e` command
  - `psql -d [db name] < [file (.sql)]` : executes the SQL commands in the .sql file for the db defined
  - `psql -d [db name]` : connects to 'db name' database and opens psql console window
  - `createdb [db name]` : create a new db with name [db name] (same as SQL command `CREATE DATABASE`)
  - `dropdb [db name]` : delete an existing db 'db name' (same as SQL command `DROP DATABASE`)
  - `psql -d [db name] < file_to_import.sql` : opens [db_name] in psql and executes sql commands in 'file_to_import.sql' within [db name] [^19]
  - `pg_dump -t my_table my_db --inserts > file.sql` : creates an sql script file of contents of 'my_table' from db 'my_db'; '--inserts' creates full `INSERT` statements to populate data [^20]q11

---

## SQL commands

### Operators
  - search postgresql documentation online:
    - 'string functions and operators'
      - `||` : concatenate strings [^15]
      - `lower()` : lowercase strings
    - 'mathematical functions and operators' : e.g., pi(), trunc(), etc.


### DDL (Data Definition Language)
  - always end with `;` - statements can be written over multiple lines
  - `SELECT * FROM orders;` : retrieve all columns from orders table
  - `SELECT side FROM orders;` : retrieve only side column from orders table
    - e.g., `SELECT id, name, age FROM birds;` : will return columns 'id', 'name', 'age' in separate columns on the scren
    - e.g., `SELECT (id, name, age) FROM birds;` : will return all data for each column grouped into 1 column; e.g., "(3,Charlie,4)"
  - `SELECT drink, side FROM orders;` : retrieve drink and side columns from orders table
  - `SELECT * FROM orders WHERE id = 1;` : retrieve all columns from orders table with a condition for rows (id = 1)
  - `SELECT customer_name FROM orders WHERE side = 'Fries';` : retrieve customer_name column from orders table with a condition for rows (side = 'Fries')
  - `CREATE DATABASE another_db;` : creates a new database called 'another_db'
  - `DROP DATABASE [db_name];` : deletes an existing database called 'db_name'
  - `DROP TABLE table_name;` : deletes a table 'table_name'
    - `DROP TABLE IF EXISTS table_name;` : checks for existence of table before dropping
    - `DROP TABLE table1, table2;` : drops multiple tables
  - `CREATE TABLE table();` : creates a table - note `()` - columns need to be defined in ()
    ```
    CREATE TABLE table (
      column_name_1 column_1_data_type [constraints, ...],
      column_name_2 column_2_data_type [constraints, ...],
      .
      .
      .
      constraints
    );
    ```
    - for example:
    ```
    CREATE TABLE users (
      id serial UNIQUE not NULL,
      username char(25),
      enabled boolean DEFAULT TRUE
    );
    ```
    - e.g., `CREATE TABLE tablename (id serial PRIMARY KEY, name varchar(50));` : can add PRIMARY KEY designation directly when defining columns of new table
    - e.g., `FOREIGN KEY (fk_col_name) REFERENCES target_table_name (pk_col_name);` : sets the 'fk_col_name' column to reference table 'target_table_name' whose primary key is col 'pk_col_name' [^10];  can separate multiple FOREIGN KEY definitions with a comma


  - `ALTER TABLE tablename` : update *schema-only* of a table
      - `RENAME TO new_name` : rename tablename to new_name
      - `RENAME COLUMN old_name TO new_name` : rename column old_name
      - `ALTER COLUMN full_name TYPE varchar(25)` : change data type of column full_name to varchar(25)
      - `ALTER COLUMN full_name SET NOT NULL;` : adds NOT NULL constraint to column 'full_name'
        - e.g., `ALTER COLUMN col_name SET DEFAULT 'value';` : sets the column 'col_name' to have a default value of 'value' in table 'tablename'
      - `ADD CONSTRAINT constraint_name constraint_type (column_name);` : add table constraints
        - e.g., `ADD CONSTRAINT unique_binomial_name UNIQUE (binomial_name)` [^4]exercise #6
	      - `ADD CHECK (full_name <> '');` : example of adding a CHECK constraint to a column [^5]
	      - `ADD UNIQUE (column_name)` : add UNIQUE to a column
      - `DROP CONSTRAINT constraint_name` : removes a constraint (from table)
      - `ALTER COLUMN col_name DROP CONSTRAINT constraint_name` : drop constraint from column
        - `DROP DEFAULT` : removes the default "constraint"
      - `ADD COLUMN new_column_name constraints` : adds a column
        - e.g. `ADD COLUMN last_login timestamp NOT NULL DEFAULT NOW();`
      - `DROP COLUMN column_name` : remove a column from tablename
      - `ADD FOREIGN KEY (column_name) REFERENCES other_table(pk_column)` : adds a foreign key constraint to a column of 'tablename' (initial 'ALTER TABLE' statement)
        
  - **additional commands can be added using a `,`**
  - `ALTER TABLE old_name RENAME TO new_name` : rename a table 'old_name' to 'new_name'
  - `ALTER TABLE users ADD PRIMARY KEY (id);` : define column 'id' as primary key for table 'users' (note this column must be 'NOT NULL' and 'UNIQUE') [^10]

  - `CREATE SEQUENCE seq_name;` : adds a sequence object to the database structure; is considered part of DDL [^16]
    - creates a new sequence with the name 'seq_name' (i.e., generates incrementing numbers, only returns a number once)

- `CASCADE` : (e.g., `ON DELETE CASCADE`) : if the row being referenced is deleted, the row referencing is also deleted [^10]


### DML (Data Manipulation Language)

- CRUD:
  - `INSERT` : add new data to table (Create)
  - `SELECT` : queries - retrieve data from tables (Read)
  - `UPDATE` : update existing data in table (Update)
  - `DELETE` : delete data from table (Delete)

- INSERT:
  - `INSERT INTO table_name (col_name, col2_name, ...) VALUES (data, data2, ...);` : add data
    - if column names aren't specified, values indicated must match order of columns in table exactly [^5]
    - can add multiple rows: e.g., `INSERT INTO table_name (col_name) VALUES (row1), (row2), (row3)`

- SELECT:
  - `SELECT col_name, ... FROM table_name WHERE condition ORDER BY column_name DESC, col_2 DESC;` (or `ASC`)
    - note: results can be returned sorted by more than 1 column (separate with a ",")
    - e.g. `SELECT enabled, full_name FROM users WHERE id < 2;` will return info from enabled and full_name columns that meet the condition id < 2
    - e.g., `WHERE expression1 AND expression2`
    - e.g., `WHERE (expression 1 OR expression2) AND expression3;

  - `SELECT * FROM table_name LIMIT 1;` : limits the number of results displayed (displays the first result)
    - e.g., `SELECT name FROM countries ORDER BY population DESC LIMIT 1;` (`LIMIT` needs to go at the end)
  - `SELECT * FROM table_name LIMIT 1 OFFSET 1;` : displays the 2nd result (limit 1 - display only 1 result; offset 1 - skip the first result)
  - `SELECT DISTINCT full_name FROM users;` : displays unique 'full_name' entries from table 'users' [^7]

  - GROUP BY: [^7]
    - splits the data within a column into groups
      - e.g., `SELECT enabled, count(id) FROM users GROUP BY enabled;` : will show enabled = false AND enabled = true and count up the number of entries corresponding to each

  - HAVING: [^8]
    - a clause which filters groups by comparing them to a conditional statement (similar to a `WHERE`, but it lets you use aggregate functions;  aggregate functions are not valid in a `WHERE` clause)
    - e.g., `SELECT species, count(id) FROM pets GROUP BY species HAVING count(id) > 1;` : returns a list of species with the corresponding number of pets of which there is more than 1 pet


- comparison operators: [^6]
  - `<`
  - `>`
  - `<=`
  - `>=`
  - `<>` or `!=`
  - `=` (used as a comparison operator in SQL and NOT assignment)
  - ==`IS NULL` and `IS NOT NULL` (**cannot** use `WHERE column_name = NULL`)==
  - `BETWEEN` `NOT BETWEEN`, `IS DISTINCT FROM`, `IS NOT DISTINCT FROM`
    - e.g., `SELECT * FROM temperatures WHERE date BETWEEN '2016-03-02' AND '2016-03-08';`
- logical operators: [^6]
  - `AND`, `OR`, `NOT`
    - e.g., `SELECT * FROM users WHERE full_name = 'Harry Potter' OR enabled = 'false';
- string matching operators: (can only be used if data type in column is a string) [^6]
  - `%` is a string wildcard - any number of characters
  - `_` is a string wildcard - only 1 character
  - `LIKE` : is case-sensitive;  e.g., `SELECT * FROM users WHERE full_name LIKE '%Smith';` (only returns matches with 'Smith' NOT 'sMITH' or 'SMITH')
  - `ILIKE` : is case-insensitive
  - can also use `SIMILAR TO` and match to regex [^6]


- using JOIN: [^11]
  - `SELECT table_nameN.col_name, ... FROM table_name1 join_type JOIN table_name2 ON join_condition;`
    - e.g., `SELECT colors.color, shapes.shape FROM colors JOIN shapes ON colors.id = shapes.color_id` :
      - from 2 different tables, 'colors' (contains id and color 'name') and 'shapes' (contains color_id FOREIGN KEY, shape 'name')
      - this returns a color 'name' and the corresponding shape 'name'

  - join_type : 
    - `INNER` : the default JOIN if no other type is specified; returns the common elements of both tables (i.e., the intersection where they match the join condition)
    - `LEFT (OUTER)` : returns all rows from the LEFT table and include matching rows from RIGHT table (or indicate NULL, if no matches are available)
    - `RIGHT (OUTER)` : returns all rows from the RIGHT table and include matching rows from LEFT table (or indicate NULL, if no matches are available)
    - `FULL (OUTER)` : returns ALL rows from BOTH tables, indicating NULL if no matches are available
    - `CROSS` : does NOT use an ON clause, returns all rows from first table crossed with every row from second table (a "cross product" of 2 sets)
  
  - multiple joins:
    - PostreSQL creates a 'transient table' (i.e., a temporary table) that contains the required info from the first join, then ADDS to this transient table with subsequent joins
    - e.g., 
    ```
    SELECT users.full_name, books.title, checkouts.checkout_date 
      FROM users 
      INNER JOIN checkouts 
        ON users.id = checkouts.user_id
      INNER JOIN books 
        ON books.id = checkouts.book_id;
    ```

  - aliasing: using another (shorter) name to reference tables
    - e.g., the query above could be written:
    ```
    SELECT u.full_name, b.title, c.checkout_date
      FROM users AS u
      INNER JOIN checkouts AS c
        ON u.id = c.user_id
      INNER JOIN books AS b
        ON b.id = c.book_id;
    ```
    - can also omit 'AS' : e.g., `SELECT u.full_name FROM users u INNER JOIN checkouts c ...`
    - e.g., `SELECT count(id) AS "Num of Books Checked Out" FROM checkouts;` : displays the column title as "Num of Books Checked Out"
  
- Subqueries: [^11]
  - using the results of 1 query in another query - "nesting" - the nested query is the 'subquery'
  - can be an alternative to a JOIN;  generally JOINs are faster than subqueries
  - e.g., `SELECT u.full_name FROM users u WHERE u.id NOT IN (SELECT c.user_id FROM checkouts c);` : subquery is "SELECT c.user_id FROM checkouts c"
  - expressions to compare value to results of a subquery:
    - `IN`
    - `NOT IN`
    - `ANY`
    - `SOME`
    - `ALL`


- UPDATE: [^9]
  - `UPDATE table_name SET column_name = value, col_2 = value2, ... WHERE expression;` : "set column(s) to these values in a table when an expression evaluates to true"
    - if the `WHERE` clause is omitted, then EVERY row in the table will be updated
    - e.g., `UPDATE users SET enabled = false;` : sets all enabled = false for all entries in table 'users'
    - e.g., `UPDATE animals SET binomial_name = 'Columbidae Columbiformes' WHERE id = 4;` : set the binomial_name to 'Columbidae Columbiformes' for the entry where id = 4 in the animals table

- DELETE: [^9]
  - `DELETE FROM table_name WHERE expression;`
    - be careful - not including the `WHERE` expression will delete ALL rows from the table


### DCL (Data Control Language)
- `GRANT`, `REVOKE` : common SQL constructs [^15]
 

---

## data types
  - search 'Chapter 8. Data Types' in SQL documentation online

  - serial : for ID columns - integers, auto-incrementing, cannot contain null value
    - not recommended for postgresql v10+
  - identity : for ID columns (better for production and db portability)
  - char(n) : string of up to n characters (with remaining space filled with spaces)
  - varchar(n) : string of up to n characters (remaining string length is unused)
  - boolean : true or false, sometimes t or f
  - integer or INT : 'whole number' ; max value is +/- 2,147,483,647 [^18]
  - decimal(precision, scale) : precision - total digits on both sides of decimal point; scale - number of digits to the right of decimal point
  - timestamp : YYYY-MM-DD HH:MM:SS format
    - timestamptz : will store timestamp with timezone
  - date : YYYY-MM-DD format
  - real : floating point numbers [^18]
  - text : unlimited length of characters [^18] (note: not part of SQL standard)


  - NULL : NULL = NULL will return *nothing* in SQL - must always use `IS NULL` or `IS NOT NULL` [^18]
    - i.e., `SELECT NULL IS NULL` will return `t` (true)

## constraints
  - DEFAULT (not technically a constraint): sets a default value for the column (i.e., when no other value is specified)
  
  - 2 types of constrants : table and column constraints - differ in syntax; not much other differences [^4]
  - NOT NULL : a value MUST be specified (cannot be left empty); generally always a column constraint [^4]

  - UNIQUE : prevent duplicate values from being entered; can be table or column constraint [^4]
  - PRIMARY KEY :  ; can be table or column constraint [^4]
  - FOREIGN KEY :  ; can be table or column constraint [^4]
  - CHECK :  ; can be table or column constraint [^4]


## SQL functions
- `now()` : provides the current date and time when called
- `count()` [^6]
  - e.g., `SELECT count(full_name) FROM users;` - will count the number of records returned (including duplicates)
  - e.g., `SELECT count(DISTINCT full_name) FROM users;` - counts distinct records returned
- string functions: [^6]
  - `length()` - returns length of string in column (e.g., `SELECT length(full_name) FROM users;` )
  - `trim()` - e.g., `SELECT trim(leading ' ' from full_name) FROM users;` (trims leading space from full_name int able users)
- date/time functions: [^6]
  - `date_part()` - e.g., `SELECT full_name, date_part('year', last_login) FROM users;` (displays full_name and year of last_login from users table)
  - `age()` - calculates time elapsed from the date passed in as argument and current time
    - e.g., `SELECT full_name, age(last_login) FROM users;`
- aggregate functions: [^6]
  - `count()`
  - `sum()`
  - `min()` : works with a variety of data types (e.g., numeric, date/time, string)
  - `max()` : works with a variety of data types (e.g., numeric, date/time, string)
  - `avg()`
  - `string_agg(col_name, delimiter)` : concatenates string values using delimiter to produce a single string [^8]

 


# References
[^1]: [Data vs Schema](https://launchschool.com/books/sql/read/basics_tutorial#datavsschema)
[^2]: [SQL SUb-languages](https://launchschool.com/books/sql/read/interacting_with_postgresql#sqlsublanguages)
[^3]: [Create and View Databases](https://launchschool.com/books/sql/read/create_database)
[^4]: [Alter Table](https://launchschool.com/books/sql/read/alter_table)
[^5]: [Inserting Data into a Table](https://launchschool.com/books/sql/read/add_data)
[^6]: [Select Queries](https://launchschool.com/books/sql/read/select_queries)
[^7]: [More on Select](https://launchschool.com/books/sql/read/more_on_select)
[^8]: [Grokking GROUP BY](https://medium.com/@iandaustin/grokking-group-by-bd0bfd7082ea)
[^9]: [Update data in a table](https://launchschool.com/books/sql/read/update_and_delete_data)
[^10]: [Table Relationships](https://launchschool.com/books/sql/read/table_relationships)
[^11]: [SQL Joins](https://launchschool.com/books/sql/read/joins)
[^12]: [Reading PostgreSQL Documentation](https://launchschool.com/lessons/234afac4/assignments/5aafff3f)
[^13]: [The PostgreSQL Command Line Interface](https://launchschool.com/lessons/234afac4/assignments/bc529bcf)
[^14]: [Quiz 1](https://launchschool.com/quizzes/35bef4aa)
[^15]: [The SQL Language](https://launchschool.com/lessons/a1779fd2/assignments/7673d9a9)
[^16]: [DML/DDL/DCL Part 10](https://launchschool.com/exercises/f59e8e95)
[^17]: [SQL Style Guide](https://launchschool.com/lessons/a1779fd2/assignments/dc780258)
[^18]: [PostgreSQL Data Types](https://launchschool.com/lessons/a1779fd2/assignments/83481591)
[^19]: [Loading Database Dumps](https://launchschool.com/lessons/a1779fd2/assignments/fa05a889)
[^20]: [NOT NULL and Default Values](https://launchschool.com/lessons/a1779fd2/assignments/c6a5a6cb)
[^21]: [More Constraints](https://launchschool.com/lessons/a1779fd2/assignments/f5b732e5)

