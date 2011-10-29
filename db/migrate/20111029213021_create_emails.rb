class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :address
      t.integer :email_type_id
      t.integer :user_id

      t.timestamps
    end
  end
end
