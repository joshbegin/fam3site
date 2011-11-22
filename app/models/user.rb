class User < ActiveRecord::Base
  
  #Use Rails 3.1 authentication
  has_secure_password
  
  # Setup relationships with other Models
#  has_many :emails, :inverse_of => :user, :dependent => :destroy
  has_many :phones, :inverse_of => :user, :dependent => :destroy
  has_many :addresses, :inverse_of => :user, :dependent => :destroy
  belongs_to :gender
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :middle_name, :last_name, :username, :gender_id, :birthdate, :password, :password_confirmation, :phones_attributes, :addresses_attributes#, :emails_attributes
  
  # Setup nested attributes
  accepts_nested_attributes_for :phones, :allow_destroy => true, :reject_if => lambda { |a| a[:number].blank? }
  accepts_nested_attributes_for :addresses, :allow_destroy => true, :reject_if => lambda { |a| a[:line_1].blank? }
#  accepts_nested_attributes_for :emails, :allow_destroy => true, :reject_if => lambda { |a| a[:content].blank? }

  # Validations
  validates_presence_of :first_name, :last_name, :username, :birthdate, :gender_id
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :username
  validates :password, :confirmation => true,
            :length => { :within => 6..40 }
  validates :password_confirmation, :presence => true
      
  scope :ordered, order("first_name ASC")
            
  def full_name
    @full_name = "#{first_name} #{middle_name} #{last_name}"
  end
end