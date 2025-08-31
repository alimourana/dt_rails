class AddUniqueIndexesToCiternes < ActiveRecord::Migration[7.1]
  def change
    add_index :citernes, :plate_number, unique: true
    add_index :citernes, :chassis_number, unique: true
  end
end
