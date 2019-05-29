class CreateOrderers < ActiveRecord::Migration[5.0]
  def change
    create_table :orderers do |t|
      t.references :customer, foreign_key: true
      t.string :family_name
      t.string :first_name
      t.string :phone_number

      t.timestamps
    end
  end
end
