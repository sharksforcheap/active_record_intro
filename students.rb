require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => 'db/students.db'
                                        
ActiveRecord::Base.connection.execute <<SQL
  CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR NOT NULL,
    last_name  VARCHAR NOT NULL,
    birthday   DATE,
    gender     VARCHAR(8),
    email      VARCHAR,
    phone      VARCHAR,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );
SQL