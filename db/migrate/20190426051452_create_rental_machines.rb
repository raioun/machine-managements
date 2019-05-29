class CreateRentalMachines < ActiveRecord::Migration[5.0]
  def change
    create_table :rental_machines do |t|
      t.string :code
      t.references :machine, foreign_key: true
      t.references :branch, foreign_key: true

      t.timestamps
      
      
    end
  end
end
