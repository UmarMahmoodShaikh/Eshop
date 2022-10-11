class CreateRetailers < ActiveRecord::Migration[7.0]
  def change
    create_table :retailers do |t|
      t.string :name
      t.string :email
      t.string :pass
      t.text :phone
      t.text :address

      t.timestamps
    end
  end
end
