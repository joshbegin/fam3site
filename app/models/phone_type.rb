class PhoneType < ActiveRecord::Base
  
  has_many :phones, :inverse_of => :phones
  
  attr_accessible :name
  
end
