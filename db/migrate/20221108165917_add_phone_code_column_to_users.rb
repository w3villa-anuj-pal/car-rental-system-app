class AddPhoneCodeColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone_code, :integer
  end
end
