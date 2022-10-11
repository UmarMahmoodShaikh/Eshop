class CreateCarts < ActiveRecord::Migration[7.0]
  def change

    create_table :carts do |t|
      t.decimal :total

      t.belongs_to :shopper
      t.belongs_to :product
      t.integer :qty
      t.jsonb :products



      t.timestamps
    end
  end
end
