class Order < ApplicationRecord
  belongs_to :project
  belongs_to :orderer
  belongs_to :rental_machine
  belongs_to :user
  
  validates :out_date, presence: true
  validates :in_date, presence: true
  
  validates :out_time, length: { maximum: 20 }
  validates :in_time, length: { maximum: 20 }
  
  enum status:{予約中: 0, 出庫中: 1, 返却済み: 2}
  
  validates :remarks, length: { maximum: 100 }
  

  validates_date :in_date, after: :out_date,
                       after_message: 'は、out_dateより先に設定できません。'
                       
  validates_date :out_date, on_or_after: lambda { Date.current },
                         on_or_after_message: 'は、過去の日付にはできません。'
  
  validate :start_end_renge_check
  
  private
    def start_end_renge_check
      record = self
      # binding pry
      orders = Order.where(rental_machine_id: self.rental_machine.id) if self
      orders = orders.where.not(id: self.id) if self.id.present?
      
      # if self
      #   orders = Order.where(rental_machine_id: self.rental_machine.id)
      #   orders = orders.where.not(id: self.id)
      # else
      #   orders = Order.all
      #   orders = orders.where(rental_machine_id: rental_machine.id)
      # end
      
      orders.each do |order|

        if order.out_date > record.out_date && order.out_date < record.in_date && order.in_date > record.out_date && order.in_date < record.in_date
          errors.add(:out_date, ":他の予定と期間が重複します")
          errors.add(:in_date, ":他の予定と期間が重複します。")
        end
        
        if order.out_date == record.out_date && order.out_date < record.in_date && order.in_date > record.out_date && order.in_date < record.in_date
          errors.add(:out_date, ":他の予定と期間が重複します")
        end
        
        if order.out_date > record.out_date && order.out_date < record.in_date && order.in_date > record.out_date && order.in_date == record.in_date
          errors.add(:in_date, ":他の予定と期間が重複します。")
        end
        
        
        
        if order.out_date <= record.out_date && order.out_date < record.in_date && order.in_date > record.out_date && order.in_date >= record.in_date
          errors.add(:out_date, ":他の予定と期間が重複します")
          errors.add(:in_date, ":他の予定と期間が重複します。")
        end
      


        if order.out_date < record.out_date && order.out_date < record.in_date && order.in_date > record.out_date && order.in_date < record.in_date
          errors.add(:out_date, ":他の予定と期間が重複します。")
        end
        
        
        
        if order.out_date > record.out_date && order.out_date < record.in_date && order.in_date > record.out_date && order.in_date > record.in_date
          errors.add(:in_date, ":他の予定と期間が重複します。")
        end
        
      end
    end
    
    
end
