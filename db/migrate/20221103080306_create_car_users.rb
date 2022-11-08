class CreateCarUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :car_users do |t|

      t.timestamps
    end
  end
end
