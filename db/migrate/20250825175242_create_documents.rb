class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.string :title, null: false
      t.string :description
      t.string :file_path
      t.string :type
      t.string :number
      t.string :status
      
      t.date :delivery_date
      t.date :expiry_date

      t.references :employee, foreign_key: true
      t.references :truck, foreign_key: true
      t.references :citernes, foreign_key: true

      t.timestamps
    end
  end
end
