class AddColumnsToArticles < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :user_shot, :featured_image
    add_column :articles, :status, :string
  end
end
