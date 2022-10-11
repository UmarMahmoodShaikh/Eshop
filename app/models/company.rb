class Company < ApplicationRecord
    validates :name,  :presence => true
    validates :email, :presence => true,uniqueness: true
    has_many :brands
end
