class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    #add_column :users, :, :string
    add_column :users, :last_name, :string
    #add_column :users, :, :string
    add_column :users, :date_of_birth, :string
    #add_column :users, :, :string
    add_column :users, :is_femaile, :boolean, default: false
    #add_column :users, :, :string
  end
end
