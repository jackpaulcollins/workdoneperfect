class EmployeeUpdates < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :attributes_from_template
    change_column_default :employees, :attributes_finished, :false
  end
end
