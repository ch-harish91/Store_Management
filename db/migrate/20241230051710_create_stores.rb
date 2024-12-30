class CreateStores < ActiveRecord::Migration[7.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.text :address
      t.decimal :overall_rating
      t.decimal :my_rating
      t.boolean :submit_rating_option
      t.boolean :modify_rating_option

      t.timestamps
    end
  end
end
