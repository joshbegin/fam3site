class Phone < ActiveRecord::Base
  
  belongs_to :user, :inverse_of => :phones
  belongs_to :phone_type, :inverse_of => :phones
  
  attr_accessible :number, :phone_type_id
  
  before_validation(:on => :create) do
    self.number = number.gsub(/[^0-9]/, "") if attribute_present?("number")
  end

  before_validation(:on => :update) do
    self.number = number.gsub(/[^0-9]/, "") if attribute_present?("number")
  end

  #validates_format_of :number, :with => /\A[0-9]{3}\-[0-9]{3}\-[0-9]{4}\Z/, :message => "must be in format 123-456-7890"
  validates_length_of :number, :is => 10, :message => "must be 10 digits"

end
