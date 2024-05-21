# Mongo DB Atlas Notes

- Official MongoDB Node.js driver library is available, but may be cumbersome (according to fsopen)
- mongoose is a higher-level library:  https://mongoosejs.com/index.html
  - could be considered an "Object Document Mapper" (ODM)
  - simplifies saving JS objects as Mongo documents

- the data stored in the database is given a schema at the level of the application, that defines teh shape of the documents stored in any given collection
  - within a single collection, documents may have completely different fields


- mongodb+srv://<userName>:<password>@<clusterName>.a86yxcp.mongodb.net/<dbName>?retryWrites=true&w=majority&appName=Test01

  - can change <dbName> in URI above: mongoDb will automatically create a new db if it doesn't already exist

```javascript
const mongoose = require('mongoose')

if (process.argv.length<3) {
  console.log('give password as argument')
  process.exit(1)
}

const password = process.argv[2]

const url =
  `mongodb+srv://fullstack:${password}@cluster0.o1opl.mongodb.net/?retryWrites=true&w=majority`

mongoose.set('strictQuery',false)

mongoose.connect(url)

// define schema
const noteSchema = new mongoose.Schema({
  content: {
    type: String,
    minLength: 5,    // built-in validator
    required: true,  // built-in validator
    unique: true, 
  },
  important: Boolean,
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User' // this references another schema (not defined here)
  }
})

// define model "Note"
const Note = mongoose.model('Note', noteSchema)
  // mongoDb will automatically name collection as 'notes' (lowercase plural)
  // models are "constructor functions" that create new objects based on given parameters

// create a new note object
const note = new Note({
  content: 'HTML is easy',
  important: true,
})

// save object to db (note that method is included in note by constructor)
note.save().then(result => {
  console.log('note saved!')
  mongoose.connection.close() // if not closed, program will never finish execution
})

// find takes an object with 'search conditions', {} is all documents
// https://www.mongodb.com/docs/manual/reference/operator/

Note.find({}).then(result => {
  result.forEach(note => {
    console.log(note)
  })
  mongoose.connection.close()
})
```

- built-in schema validators:  https://mongoosejs.com/docs/validation.html#built-in-validators
- custom schema validators:  https://mongoosejs.com/docs/validation.html#custom-validators


- MongoDb methods for retrieving documents
  - `find( {searchObj} )`
  - `findById(id)`
  - `findByIdAndDelete(id)`
  - `findByIdAndUpdate(id, {new JS Obj}, { options })`
    - note `{new JS Obj}` is the new object to be updated to - this is a JS obj, not a new Model object
    in `{ options }`:
      - `{ new: true}` indicates that the updated object should be returned by the method, not the old object that was replaced
      - `{ runValidators: true }` : indicates validators should be run
      - `{ context: 'query' }` : suggested by fsopen


- Document databases like MongoDb require the dev to make significant decisions about the db structure and schema up-front
  - see fsopen 4c:  https://fullstackopen.com/en/part4/user_administration
  - e.g., users and notes : 1 to many relationship
    - could store entire note with each user
    - could store notes id in an array of note ids with user
    - could store user id with each note
    - could also do BOTH


- use `.populate` method to simulate "joins" from a relational db


# MongoDB "Local" notes

- see scripts to setup docker contains for mongoDB container and connect to it with mongosh

- `db.getMongo()` to get connection string (note: credentials are hidden)

## commands
- simplified reference:  https://www.w3schools.com/mongodb/index.php

- `show dbs` : shows databases
  - remember: empty databases are non-existant
- `use blog` : creates a new db called 'blog'
- `db.createCollection('posts')` : creates a collection called 'posts'
- `db.posts.insertOne(object)` : insert 1 object (will also create the collection 'posts' if it doesn't exist)
  - `.insertMany([arrayOfObjects])`
- `db.posts.find()`
  - `db.posts.find( {category: 'news'} )` : includes a query object
