class AddOwnerToOauthApplication < ActiveRecord::Migration[7.1]
  def change
    add_column :oauth_applications, :call_count, :integer, default: 0, null: false
    add_column :oauth_applications, :owner_id, :bigint, null: true
    add_column :oauth_applications, :owner_type, :string, null: true
    add_column :oauth_applications, :last_used_at, :datetime

    add_reference :oauth_applications, :created_by, index: true
    
    add_index :oauth_applications, [:name, :owner_id, :owner_type], unique: true
  end
end
