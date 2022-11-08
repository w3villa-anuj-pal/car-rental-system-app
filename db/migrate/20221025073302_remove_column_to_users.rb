class RemoveColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :name, :string
    remove_column :users, :image, :string
    remove_column :users, :provider_name, :string
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
  end
end
