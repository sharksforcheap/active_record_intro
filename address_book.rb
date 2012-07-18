require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => 'db/address_book.db'
                                        
ActiveRecord::Base.connection.execute <<SQL
  -- Address book schema

  CREATE TABLE contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR,
    last_name  VARCHAR,
    birthday   DATE,
    email      VARCHAR,
    phone      VARCHAR,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );
SQL

ActiveRecord::Base.connection.execute <<SQL
  CREATE TABLE addresses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    contact_id INTEGER NOT NULL,
    street_address  VARCHAR,
    street_address2 VARCHAR,
    city            VARCHAR,
    state           VARCHAR,
    country         VARCHAR,
    zip             VARCHAR,
    FOREIGN KEY (contact_id) REFERENCES contacts(id)
  );
SQL
