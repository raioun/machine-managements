class Place < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, length: { maximum: 80 }
end
