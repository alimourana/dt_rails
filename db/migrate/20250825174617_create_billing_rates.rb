class CreateBillingRates < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_rates do |t|
      t.string :origin, null: false
      t.string :destination, null: false
      t.decimal :rate, null: false

      t.timestamps
    end
  end
end
