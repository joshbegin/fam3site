class AddPrimaryToEmailPhoneAddress < ActiveRecord::Migration
  def change
  	add_column :emails, :primary, :boolean, default: false
  	add_column :addresses, :primary, :boolean, default: false
 	add_column :phones, :primary, :boolean, default: false
  end
end
