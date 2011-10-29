class Email < ActiveRecord::Base
  
  attr_accessible :address, :email_type_id
  
  belongs_to :user
  belongs_to :email_type
  
  validates_format_of :address, :with => /.+\@.+\..+/

end
