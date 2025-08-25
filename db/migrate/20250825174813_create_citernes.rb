class CreateCiternes < ActiveRecord::Migration[7.1]
  def change
    create_table :citernes do |t|
      t.string :plate_number, null: false
      t.string :chassis_number, null: false
      t.string :capacity, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
