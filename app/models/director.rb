class Director < ApplicationRecord
  validates :name, length: {minimum: 3}
  has_many :movies
end
