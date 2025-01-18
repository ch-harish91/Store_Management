class AddStoreIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :store_id, :integer
  end
end
