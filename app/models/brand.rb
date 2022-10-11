class Brand < ApplicationRecord
    # validates :name, :presence => true,uniqueness: true
    # validates :slogan, :presence => true,uniqueness: true
    belongs_to :company
end
