class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :about
      t.string :email

      t.timestamps
    end
  end
end
