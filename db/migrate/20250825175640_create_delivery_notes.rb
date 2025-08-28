class CreateDeliveryNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :delivery_notes do |t|
      t.string :number, null: false
      t.string :status, null: false
      t.string :origin, null: false
      t.string :destination, null: false
      t.string :gasoline_quantity, null: false
      t.string :diesel_quantity, null: false
      t.string :total_quantity, null: false
      t.string :missing_quantity, null: false
      t.string :missing_description, null: false
      t.string :updated_by, null: false
      t.string :created_by, null: false

      t.date :issued_date, null: false
      t.date :delivery_date, null: false
      t.date :return_date, null: false
      
      t.references :employee, foreign_key: true
      t.references :truck, foreign_key: true
      t.references :citernes, foreign_key: true

      t.timestamps
    end
  end
end
