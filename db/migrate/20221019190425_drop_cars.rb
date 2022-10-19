class DropCars < ActiveRecord::Migration[6.1]
  def change
    def up
      drop_table :cars
    end
  
    def down
      fail ActiveRecord::IrreversibleMigration
    end
  end
end
