class AddressType < ActiveRecord::Base
  
  has_many :addresses
  
  attr_accessible :name
  
#  accepts_nested_attributes_for :address_type

end
