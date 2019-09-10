class AddAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :street_address, :string, null: false
    add_column :users, :city, :string, null: false
    add_column :users, :state, :string, null: false
    add_column :users, :zip_code, :integer, null: false
  end
end
