class Genre < ApplicationRecord
  validates :name, length: {minimum: 3}, uniqueness: true
  has_many :movies

end
