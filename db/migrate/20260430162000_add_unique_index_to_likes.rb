class AddUniqueIndexToLikes < ActiveRecord::Migration[8.0]
  def change
    remove_index :likes, [:user_id, :post_id] if index_exists?(:likes, [:user_id, :post_id])
    add_index :likes, [:user_id, :post_id], unique: true
  end
end
