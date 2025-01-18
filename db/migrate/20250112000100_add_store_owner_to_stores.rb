class AddStoreOwnerToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :store_owner, :string
  end
end
