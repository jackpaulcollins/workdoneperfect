class AddJsonColumnToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :template_attributes, :jsonb
  end
end
