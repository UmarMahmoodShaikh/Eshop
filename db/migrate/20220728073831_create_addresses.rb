class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :name
      t.text :detail
      t.belongs_to :shopper

      t.timestamps
    end
  end
end
