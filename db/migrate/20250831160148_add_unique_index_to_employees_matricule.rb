class AddUniqueIndexToEmployeesMatricule < ActiveRecord::Migration[7.1]
  def change
    add_index :employees, :matricule, unique: true
  end
end
