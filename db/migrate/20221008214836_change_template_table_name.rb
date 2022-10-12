class ChangeTemplateTableName < ActiveRecord::Migration[7.0]
  def change
    drop_table :employee_templates
    rename_table :templates, :employee_templates
  end
end
