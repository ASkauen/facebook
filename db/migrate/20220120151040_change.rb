class Change < ActiveRecord::Migration[6.1]
  def change
    rename_column :friendships, :user_id, :user_a_id
    rename_column :friendships, :friend_id, :user_b_id
  end
end
