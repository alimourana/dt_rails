class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.references :user, null: false, foreign_key: true
      t.string :matricule, null: false
      t.string :department
      t.string :position
      t.string :status
      t.string :salary

      t.timestamps
    end
  end
end
