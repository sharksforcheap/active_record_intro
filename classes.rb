require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => 'db/classes.db'
                                        
ActiveRecord::Base.connection.execute <<SQL
  -- Teachers and students go in this table
  -- The 'staff' field is 't' for teachers, 'f' for students
  CREATE TABLE people (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name  VARCHAR(64) NOT NULL,
    email      VARCHAR(128) NOT NULL,
    staff      BOOLEAN NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );

  CREATE TABLE classes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    department_id INTEGER NOT NULL,
    name          VARCHAR NOT NULL,
    created_at    DATETIME NOT NULL,
    updated_at    DATETIME NOT NULL,
    FOREIGN KEY(department_id) REFERENCES departments(id)
  );

  CREATE TABLE sections (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id        INTEGER NOT NULL,
    teacher_id      INTEGER NOT NULL,
    section_type_id INTEGER NOT NULL,
    start_time      DATETIME NOT NULL,
    end_time        DATETIME NOT NULL,
    created_at      DATETIME NOT NULL,
    updated_at      DATETIME NOT NULL,
    FOREIGN KEY(class_id) REFERENCES classes(id),
    FOREIGN KEY(teacher_id) REFERENCES people(id),
    FOREIGN KEY(section_type_id) REFERENCES section_types(id)
  );

  -- e.g., 'MWF', 'TuTh'
  CREATE TABLE section_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(32) NOT NULL
  );

  -- Grade is a decimal from 0.000 to 4.000
  CREATE TABLE sections_students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    section_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    grade DECIMAL(4,3),
    FOREIGN KEY(section_id) REFERENCES sections(id),
    FOREIGN KEY(student_id) REFERENCES people(id)
  );

  CREATE TABLE departments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(32) NOT NULL
  );
SQL
