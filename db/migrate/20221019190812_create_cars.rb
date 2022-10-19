class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :car_name
      t.string :vehicle_no
      t.string :captain_name

      t.timestamps
    end
  end
end
