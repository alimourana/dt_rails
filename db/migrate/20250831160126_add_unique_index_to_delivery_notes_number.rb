class AddUniqueIndexToDeliveryNotesNumber < ActiveRecord::Migration[7.1]
  def change
    add_index :delivery_notes, :number, unique: true
  end
end
