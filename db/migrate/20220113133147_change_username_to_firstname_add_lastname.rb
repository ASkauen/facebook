class ChangeUsernameToFirstnameAddLastname < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :username, :first_name
    add_column :users, :last_name, :string
  end
end
