class Phone < ActiveRecord::Base
  
  belongs_to :user, :inverse_of => :phones
  belongs_to :phone_type, :inverse_of => :phones
  
  attr_accessible :number, :phone_type_id
  
  validates_format_of :number, :with => /\d{10}/
  
end
