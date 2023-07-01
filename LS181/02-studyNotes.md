# SQL

<details>
<summary>Identify the different types of JOINs and explain their differences</summary>

- a JOIN is used to query data from more than 1 table [^5]

## (INNER) JOIN
- returns a result set that contains common elements of both tables (i.e., the intersection where elements from both tables match on the join condition) [^5]
- syntax: [^11]
  - `SELECT * FROM table1 JOIN table2 ON table1.table2_id = table2.id;`
  - `SELECT * FROM table1, table2 WHERE table1.table2_id = table2.id;` (uses CROSS JOIN first, then adds WHERE condition; older syntax, still supported)

## LEFT (OUTER) JOIN
- returns ALL of the results from the FIRST (left) table and the matching elements of the second (right) table [^5]
  - NULL values are used where there is no matching data

## RIGHT (OUTER) JOIN
- returns ALL of the results from the SECOND (right) table and the matching elements of the first (left) table [^5]
  - NULL values are used where there is no matching data

## FULL (OUTER) JOIN
- returns ALL of the results from BOTH tables [^5]
  - NULL values are used where there is no matching data

## CROSS JOIN
- takes every row of the FIRST table and combines it with every row of the SECOND table [^5]
- also known as a Cartesian JOIN [^5]
- syntax: [^11]
  - `SELECT * FROM table1 CROSS JOIN table2;` (note: no 'ON' in join clause)
  - `SELECT * FROM table1, table2;` (alternate notation)

</details>

---

<details>
<summary>Name and define the three sublanguages of SQL and be able to classify different statements by sublanguage</summary>

## DDL (Data Definition Language)
- defines the *structure* (schema) of a database and the tables and columns within it [^1]
- controls relation (table) structure and rules [^6]
  - e.g., `CREATE`, `DROP`, `ALTER`

## DML (Data Manipulation Language)
- used to retrieve (query) or modify *data* stored in a database [^1]
- controls values stored within relations (tables) [^6]
  - e.g., `INSERT`, `SELECT`, `UPDATE`, `DELETE`

## DCL (Data Control Language)
- used to determine what various users are allowed to do when interacting with a database [^1]
- controls who can do what [^6]
  - e.g., `GRANT`, `REVOKE`

</details>

---

<details>
<summary>Write SQL statements using INSERT, UPDATE, DELETE, CREATE/ALTER/DROP TABLE, ADD/ALTER/DROP COLUMN</summary>

## INSERT INTO
- `INSERT INTO table_name (col1, col2, ...) VALUES (val11, val12, ...), (val21, val22, ...);`
- inserting into a column that doesn't exist will return an error

## UPDATE
- `UPDATE table SET col_name = new_val [ WHERE condition ]`

## DELETE FROM
- `DELETE FROM table [ WHERE condition ]`

## ALTER TABLE
- `ALTER TABLE table_name` followed by:
  - `RENAME TO new_name` [^3]
  - `RENAME COLUMN old_name TO new_name` [^3]
  - `ADD COLUMN col_name type constraints`
  - `DROP COLUMN col_name`
  - `ALTER COLUMN col_name` followed by:

## ALTER COLUMN
- `ALTER COLUMN col_name` followed by:
  - `TYPE new_type [ USING col_name::type ]` [^3]
  - `SET NOT NULL` [^3]

</details>

---

<details>
<summary>Understand how to use GROUP BY, ORDER BY, WHERE, and HAVING</summary>

- `GROUP BY col1, col2` : ensure all columns being selected are also grouped or aggregated by function
- `ORDER BY col1 { [ ASC ] | DESC }, col2 { [ ASC ] | DESC }`

- `WHERE condition` : used to filter rows in table; condition must evaluate to a single value to be compared to each row (cannot use aggregate functions)
- `HAVING condtiion` : used to filter *grouped* rows in table

- always remember NULL must be specifically considered - it's an 'additional' value [^7]
  - NULL values:
    - sort to the top (DESC) or last (ASC), distinct from other values
    - cannot be compared using operators
    - may impact systems downstream of the database (e.g., how to handle NULL amounts?)
    - require the use of `IS NULL` and `IS NOT NULL` as comparators

</details>

---

<details>
<summary>Understand how to create and remove constraints, including CHECK constraints</summary>

## Add when defining a table (CREATE TABLE)
- add keyword after column type: `UNIQUE`, `NOT NULL`, `DEFAULT default_value` [^2]
- can also add `PRIMARY KEY`, `REFERENCES other_table(pk)column` directly when defining a column in a new table

## Add to existing table (ALTER TABLE)
- need to include `ALTER TABLE table_name` :

  - `ALTER COLUMN col_name SET column_constraint` (for column constraints) [^3]
  - `ALTER COLUMN col_name DROP column_constraint`
    - works for:
      - `NOT NULL`
      - `DEFAULT`

  - `ADD [ CONSTRAINT constraint_name ] table_constraint;` (for table constraints) [^3]
  - `DROP CONSTRAINT constraint_name` [^3]
    - works for:
      - `CHECK (expression)`
      - `UNIQUE (col_name)`
      - `PRIMARY KEY (col_name)`
      - `FOREIGN KEY (col_name) REFERENCES other_table(pk_column) [ ON DELETE CASCADE ]`


- Note:  Defining `PRIMARY KEY` [^8]
  - is roughly equivalent to adding `NOT NULL UNIQUE`
  - does not automatically create a serial type - this must be defined
  - adding a new primary key column (using serial) to a table with existing data will autopopulate the id's

</details>

---

<details>
<summary>Be familiar with using subqueries</summary>

- when queries are 'nested' (i.e., the result of 1 query is used as part of another query) the nested query is called a *subquery* [^5]
- subqueries could be preferable if data isn't being returned from both tables, but the data being selected may be dependent on another table [^14]

- subquery expressions [^14]
  - `EXISTS` : if any row is returned in subquery it returns 'true'
  - `IN` : if subquery returns the specified row it returns 'true'
  - `NOT IN` : if subquery does NOT return the specified row it returns 'true'
  - `ANY` / `SOME` : if ANY of the returned values in subquery meet condition, it returns 'true'
  - `ALL` : if ALL of the returned values in subquery meet condition, it returns 'true'

</details>

---

# PostgreSQL

<details>
<summary>Describe what a sequence is and what they are used for</summary>

## Sequence
- a special kind of relation that generates a series of numbers; it remembers the last number generated and will never return a number in a sequence again [^8]
  - great for use as database keys (e.g., `serial`)

</details>

---

<details>
<summary>Create an auto-incrementing column</summary>

## Using a Sequence
- `CREATE SEQUENCE seq_name;` : creates a new sequence 'seq_name' [^8]
  - `nextval('seq_name')` : returns the next value in the sequence
  - e.g., `CREATE SEQUENCE even_counter INCREMENT BY 2 MINVALUE 2;` : sequence 'even_counter' only returns even numbers
  - define DEFAULT for column to be `nextval('seq_name')`
  - e.g., `CREATE TABLE colors (id integer NOT NULL DEFAULT nextval('colors_seq_id') );`

## Use data type serial
- e.g., `CREATE TABLE colors (id serial);`

</details>

---

<details>
<summary>Define a default value for a column</summary>

- `CREATE TABLE table_name (col_name type DEFAULT default_value);`

- `ALTER TABLE table_name`
  - `ALTER COLUMN col_name SET DEFAULT default_value`
  - `ALTER COLUMN col_name DROP DEFAULT`

- Note: A default must match the data type of the column it is being applied to.
  - However, when defining a numeric default to a text column, PostgreSQL will cast the number into text


</details>

---

<details>
<summary>Be able to describe what primary, foreign, natural, and surrogate keys are</summary>

- a **key** uniquely identifies a single row in a database table [^8]

## Primary Key
- a unique identifier for a row of data, equivalent to adding 'NOT NULL' and 'UNIQUE' [^4]
- each table can have only 1 PRIMARY KEY [^4]

## Foreign Key
- when a column of data in one table references the primary key of another table - this creates a connection with another table [^4]
- defining a foreign key constraint preserves *referential integrity* of data - i.e., database will ensure every value in a foreign key column exists in the primary key column of referenced table [^12]

## Natural Key
- an existing value in a dataset that can be used to uniquely identify each row of data in that dataset [^8]
  - generally, natural keys aren't ideal - duplications or changes are possible
  - could use a *composite key* - a key comprised of more than 1 existing value

## Surrogate Key
- a value created solely for the purpose of identifying a row of data in a database table [^8]
  - most common is an auto-incrementing integer


</details>

---

<details>
<summary>Create and remove CHECK constraints from a column</summary>

- `CREATE TABLE table_name (col_name type CHECK (constraint));`

- `ALTER TABLE table_name` :
  - `ADD [ CONSTRAINT constraint_name ] CHECK (expression)`
  - `DROP CONSTRAINT constraint_name`

</details>

---

<details>
<summary>Create and remove foreign key constraints from a column</summary>

- `CREATE TABLE table_name (col_name integer REFERENCES other_table(pk_col) );`
  - add foreign key column and constraint when defining a new table

- `ALTER TABLE table_name`
  - `ADD FOREIGN KEY (col_name) REFERENCES other_table(pk_col) [ ON DELETE CASCADE ]`
  - `DROP CONSTRAINT foreign_key_constraint_name`

- Note:  cannot add a foreign key which references a table that doesn't exist

</details>

---

# Database Diagrams

<details>
<summary>Talk about the different levels of schema</summary>

## Conceptual schema
- high-level design focused on identifying entities (relations) and relationships 
- most abstract level [^9]
- also called Entity-Relationship-Diagrams (ERDs) or entity-relationship model
- there may be more tables than entities (e.g., M:M relationships require a JOIN table)

## Logical schema
- "in-between" conceptual and physical
- may contains details about the database, but those details wouldn't be implementation-specific

## Physical schema
- low-level, database-specific design focused on implementation details [^9]
- least abstract level; most detail
- contains specific attributes by entity, data types, rules / constraints about how entities relate to each other

</details>

---

<details>
<summary>Define cardinality and modality</summary>

## Cardinality
- the number of objects on each side of the relationship (1:1, 1:M, M:M) [^10]
  - refers to if that entity can have "1" or "M"any

## Modality
- determines if the relationship is required (1) or optional (0) [^10]
  - can be thought of as the MINIMUM number of objects of that entity:
    - if required: there must be at least 1 object
    - if optional: there can be 0 objects

</details>

---

<details>
<summary>Be able to draw database diagrams using crow's foot notation</summary>

- drawing ERDs: [^9]
  - key relationships:
    - 1:1 : one-to-one : shown with a line
    - 1:M : one-to-many : shown with a "crow's foot"
    - M:M : many-to-many : shown with a "double-foot"
  - when modelling 1:M:
    - on "M" side : add FOREIGN KEY (not UNIQUE)
    - on "1" side : add PRIMARY KEY

</details>

---

# Other

## Comparison Operators
- `BETWEEN` :  e.g., `WHERE date BETWEEN '2016-02-03' AND '2016-02-28'`
- `NOT BETWEEN`
- `IS DISTINCT FROM`
- `IS NOT DISTINCT FROM`
- `LIKE` : case-sensitive; e.g., `WHERE full_name LIKE '%Smith'`
  - `%` string wildcard - any number of characters
  - `_` string wildcard - only 1 character
- `ILIKE` : case-insensitive
- `SIMILAR TO` : uses regex match


## Indexes [^13]
- `CREATE INDEX [index_name] ON table_name (field_name1, field_name2, ... )`
- `DROP INDEX index_name`


## Meta-commands
- `\copy target_table from 'file.csv' WITH DELIMITER ',' CSV HEADER` : import csv to current database
- `\i file.sql` : import sql commands

## Referential integrity
- (from PostgreSQL docs on "foreign key constraints") *Referential Integrity* between 2 related tables is maintained when the values in a column (or group of columns) must match the values appearing in some row of another table.

## Using ROW
- e.g., `SELECT id FROM items WHERE ROW(name, initial_price, sales_price) = ROW('Painting', 100.00, 250.00);`

---

# References

[^1]: [SQL Sub-Languages](https://launchschool.com/books/sql/read/interacting_with_postgresql#sqlsublanguages)
[^2]: [Create and View Tables](https://launchschool.com/books/sql/read/create_table)
[^3]: [Alter Table](https://launchschool.com/books/sql/read/alter_table)
[^4]: [Table Relationships](https://launchschool.com/books/sql/read/table_relationships)
[^5]: [SQL Joins](https://launchschool.com/books/sql/read/joins)
[^6]: [The SQL Language](https://launchschool.com/lessons/a1779fd2/assignments/7673d9a9)
[^7]: [NOT NULL and Default Values](https://launchschool.com/lessons/a1779fd2/assignments/c6a5a6cb)
[^8]: [Using Keys](https://launchschool.com/lessons/a1779fd2/assignments/00e428da)
[^9]: [Database Diagrams: Levels of Schema](https://launchschool.com/lessons/5ae760fa/assignments/2f3bc8f7)
[^10]: [Database Diagrams: Cardinality and Modality](https://launchschool.com/lessons/5ae760fa/assignments/46053e3b)
[^11]: [A Review of JOINs](https://launchschool.com/lessons/5ae760fa/assignments/0391f663)
[^12]: [Using Foreign Keys](https://launchschool.com/lessons/5ae760fa/assignments/bb4f3ba2)
[^13]: [Indexes ](https://launchschool.com/lessons/e752508c/assignments/17c58bc3)
[^14]: [Subqueries ](https://launchschool.com/lessons/e752508c/assignments/2009d549)
---

# Follow-up Questions

- [X] `PRIMARY KEY` : what constraints does this add?  What conditions?  What kinds of data types can be 'primary key's?
  - A: applying 'PRIMARY KEY' applies 'NOT NULL' AND 'UNIQUE' [^38]q4
  - A: any data type can be a primary key, as long as it's unique and not-null
  - A: note:  primary key columns do NOT need to be auto-incrementing and a sequence is NOT added by default

- [X] ERD diagrams - confirm I'm reading them the right way (w/ modality)
  - A: entityA 1 to entityB 0 implies that an entityB does not need to exist for an entityA, but IF an entityB exists, it *must* have an entityA

- [X] Given the db can do quite a few calcs, does it make more sense to do those calcs in the db, or in the application?
  - A: would depend on recency of data (from db) vs time (latency) on the HTTP connection to ping the db again

- [X] character datatype : I can see space-padding when the column is 'selected', however when I call a string function (e.g., length) it doesn't seem to register the space
    - bit_length, length, char_length are all equivalent and do not register the space-padding
    - octet_length appears to register the space padding (octet_length will be length of char w/ space padding)

- [X] Spot ques #2 - confirm a tuple is the actual data; attributes are fields (the schema)
  - from SPOT session: may not be important
  - A: attributes of the 'table' become the fields in the table

- [ ] Spot ques #5 - what order are columns pulled?
- [ ] Spot ques #15 - indexes - assuming all cols with an "index" entry are indexes?
      - [ ] defining a column as unique creates an index - fair to call it a natural key?
      - [ ] what type of algorithms?
- [ ] Spot ques #22 - error messages : do these come from PostgreSQL or SQL?

- [ ] terminology : field vs column?
  - A: PostgreSQL docs use 'column'
      - [X] WHERE is a clause?
        - A: YES - based on the PostgreSQL docs (see 'SELECT')

- [X] Review quizzes:
    - [X] quiz 1 q3, q5, q15
    - [ ] 

---

# Prep

- [X] review lessons - make study guide notes
- [x] Practice:
      - Create 'real' scenario (w/ multiple entities / relationships)
      - Sketch ERD
      - Create (define) tables
      - Populate w/ test data (from files - i.e., skills practice for assessment)
      - Retrieve data using subqueries AND joins (from .sql files)
      - Compare those queries

- [x] do spot questions
- [X] do quizzes again
- [ ] review trouble areas

- [ ] https://pgexercises.com/questions/joins/