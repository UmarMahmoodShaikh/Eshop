class CreateBrands < ActiveRecord::Migration[7.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.text :slogan
      t.belongs_to :company

      t.timestamps
    end
  end
end
