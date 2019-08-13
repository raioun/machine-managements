class AddStorageToRentalMachines < ActiveRecord::Migration[5.0]
  def change
    add_reference :rental_machines, :storage, foreign_key: true
  end
end
