class AddColumnToCars < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :seater, :string
    add_column :cars, :vehicle_type, :string
  end
end
