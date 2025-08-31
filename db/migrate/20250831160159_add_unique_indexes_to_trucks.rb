class AddUniqueIndexesToTrucks < ActiveRecord::Migration[7.1]
  def change
    add_index :trucks, :plate_number, unique: true
    add_index :trucks, :vin, unique: true
  end
end
