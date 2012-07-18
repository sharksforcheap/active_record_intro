class Student < ActiveRecord::Base
  # "NOT NULL" validation
  validates :first_name, :presence => true
  validates :last_name,  :presence => true
  
  # One doesn't typically include validations for
  # created_at and updated_at since Rails manages those  
end