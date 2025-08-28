class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :encrypted_password
      t.string :phone_number
      t.string :address_line
      t.string :city
      t.string :state
      t.string :country
      t.string :role, default: "user"
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
