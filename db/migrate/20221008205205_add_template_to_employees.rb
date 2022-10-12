class AddTemplateToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_reference :employees, :template, index: true
  end
end
