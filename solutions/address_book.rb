class Contact < ActiveRecord::Base
  # :dependent => :destroy tells Rails to delete 
  # a contact's associated addresses when the contact
  # is deleted
  has_many :addresses, :dependent => :destroy
end

class Address < ActiveRecord::Base
  belongs_to :contact

  validates :contact_id, :presence => true
  
  # It's rare that a Rails app enforces foreign key contraints
end