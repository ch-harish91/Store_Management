class AddUserIdToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :user_id, :integer
  end
end
