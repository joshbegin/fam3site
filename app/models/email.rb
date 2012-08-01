class Email < ActiveRecord::Base
  
  attr_accessible :address, :email_type_id
  
  belongs_to :user
  belongs_to :email_type

  before_save do
    self.address = address.downcase
  end
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :address, format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
  
end
