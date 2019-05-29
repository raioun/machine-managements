class RentalMachine < ApplicationRecord
  belongs_to :machine
  belongs_to :branch
  
  validates :code, length: { maximum: 10 }
  
  has_many :orders
  has_many :projects, through: :orders
  has_many :orderers, through: :orders
  has_many :users, through: :orders
  
  def rental_machine_full_name
    '機材名：' + self.machine.name + '/' + self.machine.type1 + '/' + self.machine.type2 + '/' + '機番：' + self.code + '/' + '所有営業所名：' + self.branch.company.name + '/' + self.branch.name
  end
  
end
