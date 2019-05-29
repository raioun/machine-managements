class Project < ApplicationRecord
  belongs_to :customer
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, length: { maximum: 80 }
  
  has_many :orders
  has_many :orderers, through: :orders
  has_many :rental_machines, through: :orders
  has_many :users, through: :orders

  
  def project_full_name
    self.customer.name + '/' + self.name
  end
  
  # def self.search(search)
  #   if search
  #     Project.where('customer_id LIKE? OR name LIKE?', "%#{search}%", "%#{search}%")
  #   else
  #     Project.all
  #   end
  # end
end
