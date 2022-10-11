class AddFinsihedToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :attributes_finished, :boolean
  end
end
