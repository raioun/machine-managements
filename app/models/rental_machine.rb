class RentalMachine < ApplicationRecord
  belongs_to :machine
  belongs_to :branch
  
  # validates :machine
  
  # validates :branch
  
  # def machine
  #   Machine.find_by(id: machine_id)
  # end
  
  # def branch
  #   Branch.find_by(id: branch_id)
  # end
  
  # foreign_key :machine, :branch 定義されていないエラー
  # references :machine 定義されていないエラー
  # @machine.attributes 定義されていないエラー
  # @branch.attributes 定義されていないエラー
  # binding.pry
  # machine.attribute_for_inspect(:machine_id) undefined local variable or method `machine' for #<Class:0x007fae5dc373b0>
  # branch.attribute_for_inspect(:branch_id) undefined local variable or method `machine' for #<Class:0x007fae5dc373b0>

  validates :code, length: { maximum: 10 }
  
  has_many :orders
  has_many :projects, through: :orders
  has_many :orderers, through: :orders
  has_many :users, through: :orders
 
  # def projects
  #   projects=[]
  #   Order.wehre(rental_machine_id: id).each do |order|
  #     projects << Project.find_by(id: order.project_id)
  #   end
  #   return projects
    
  # end
 
  
  enum status:{良品: 0, 重整備: 1, 廃棄済み: 2}
  
  def rental_machine_full_name
    '機材名：' + self.machine.name + '/' + self.machine.type1 + '/' + self.machine.type2 + '/' + '機番：' + self.code + '/' + '所有営業所名：' + self.branch.company.name + '/' + self.branch.name
  end
  
end
