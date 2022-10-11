class AddPassToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :password_digest, :string
  end
end
