class AddCustomAttributesToEmployees < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :name
    add_column :employees, :first_name, :string
    add_column :employees, :last_name, :string
    add_column :employees, :template_attributes, :string, array: true, default: []
  end
end
