class AddIndexToComments < ActiveRecord::Migration[8.0]
  def change
    # Just add a regular index for performance, not unique
    # since users should be able to comment multiple times on the same post
    add_index :comments, [:post_id, :created_at]
  end
end
