class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :avatar, :string
    remove_column :users, :profile_image
    
  end
end
