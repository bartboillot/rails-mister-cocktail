class Ingredient < ApplicationRecord
  has_many :doses
  has_many :cocktails
  validates :name, uniqueness: true, presence: true

end
