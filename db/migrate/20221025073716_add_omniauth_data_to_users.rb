class AddOmniauthDataToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :image, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
