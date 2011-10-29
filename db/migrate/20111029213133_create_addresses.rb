class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :line_3
      t.string :city
      t.integer :state_id
      t.string :zip
      t.integer :user_id
      t.integer :address_type_id

      t.timestamps
    end
  end
end
