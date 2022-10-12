class ChangeEmployeeTemplateToBeJson < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :template_attributes
  end
end
