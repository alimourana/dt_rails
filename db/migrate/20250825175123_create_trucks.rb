class CreateTrucks < ActiveRecord::Migration[7.1]
  def change
    create_table :trucks do |t|
      t.string :make, null: false
      t.string :model, null: false
      t.string :plate_number, null: false
      t.string :status, null: false
      t.string :vin, null: false

      t.references :employee, null: false, foreign_key: true
      t.references :citernes, null: false, foreign_key: true

      t.timestamps
    end
  end
end
