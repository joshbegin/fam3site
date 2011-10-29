class EmailType < ActiveRecord::Base
  
  has_many :emails
  
  attr_accessible :name
  
end
