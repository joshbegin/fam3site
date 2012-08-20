class Address < ActiveRecord::Base
  
  attr_accessible :line_1, :line_2, :line_3, :city, :state_id, :zip, :address_type_id, :primary
  
  belongs_to :user
  belongs_to :state
  belongs_to :address_type
  
end
