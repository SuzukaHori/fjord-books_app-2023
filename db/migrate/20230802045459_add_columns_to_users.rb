class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :postcode, :string
    add_column :users, :address, :string
    add_column :users, :introduction, :text
  end
end
