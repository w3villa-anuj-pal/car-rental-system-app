class AddColumnToCarUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :car_users, :user, null: false, foreign_key: true
    add_reference :car_users, :car, null: false, foreign_key: true
  end
end
