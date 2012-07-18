require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => 'db/polls.db'
                                        
ActiveRecord::Base.connection.execute <<SQL
  -- Polls schema
  -- One row per user
  CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR NOT NULL,
    last_name  VARCHAR NOT NULL,
    email      VARCHAR NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );
SQL
ActiveRecord::Base.connection.execute <<SQL
  -- One row per poll
  -- e.g.,
  -- (1,1,"Who are you voting for in 2012?")
  --
  -- "user_id" points to the user who created the poll
  CREATE TABLE polls (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER NOT NULL,
    -- e.g., "Who are you voting for in 2012?"
    question   VARCHAR NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
  );
SQL
ActiveRecord::Base.connection.execute <<SQL

  -- One row per (potential) response in a poll
  -- e.g., 
  -- (1,1,"Barack Obama")
  -- (2,1, "Mitt Romney")
  CREATE TABLE responses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    poll_id INTEGER NOT NULL,
    -- e.g., "Mitt Romney"
    content VARCHAR NOT NULL, 
    FOREIGN KEY(poll_id) REFERENCES polls(id)
  );
SQL
ActiveRecord::Base.connection.execute <<SQL
  -- One row per vote in a poll
  -- "user_id" points to the user who voted in the poll
  -- "poll_Id" points to the poll voted in
  -- "response_id" points to the selected response
  CREATE TABLE votes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL,
    poll_id     INTEGER NOT NULL,
    response_id INTEGER NOT NULL,
    created_at  DATETIME NOT NULL,
    updated_at  DATETIME NOT NULL,
    FOREIGN KEY(poll_id) REFERENCES polls(id),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(response_id) REFERENCES responses(id)
  );

SQL