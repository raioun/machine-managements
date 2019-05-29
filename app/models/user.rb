class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :orders
  has_many :projects, through: :orders
  has_many :orderers, through: :orders
  has_many :rental_machines, through: :orders
end
