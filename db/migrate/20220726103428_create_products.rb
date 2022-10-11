class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.belongs_to :brand
      t.integer :quantity
      t.boolean :availability
      t.belongs_to :subcategory

      t.timestamps
    end
  end
end
