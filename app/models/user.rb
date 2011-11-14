class User < ActiveRecord::Base
  
  #Use Rails 3.1 authentication
  has_secure_password
  
  # Setup relationships with other Models
  has_many :emails, :inverse_of => :user, :dependent => :destroy
  has_many :phones, :inverse_of => :user, :dependent => :destroy
  has_many :addresses, :inverse_of => :user, :dependent => :destroy
  belongs_to :gender
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :middle_name, :last_name, :username, :gender_id, :birthdate, :password, :password_confirmation, :remember_me, :phones_attributes, :addresses_attributes, :emails_attributes
  
  # Setup nested attributes
  accepts_nested_attributes_for :phones, :allow_destroy => true
  
  # Validations
  validates_presence_of :first_name, :last_name, :username, :birthdate, :gender_id
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :username
  validates :password, :confirmation => true,
            :length => { :within => 6..40 }
  validates :password_confirmation, :presence => true
            
  def full_name
    @full_name = "#{first_name} #{middle_name} #{last_name}"
  end
end