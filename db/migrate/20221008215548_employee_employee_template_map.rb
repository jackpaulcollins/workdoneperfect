class EmployeeEmployeeTemplateMap < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :template_id
    add_reference :employees, :employee_template, index: true
  end
end
