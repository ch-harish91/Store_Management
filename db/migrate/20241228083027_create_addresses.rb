class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :area
      t.string :city
      t.string :pincode
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
