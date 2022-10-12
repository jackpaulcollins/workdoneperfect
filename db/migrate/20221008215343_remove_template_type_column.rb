class RemoveTemplateTypeColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :employee_templates, :template_type
  end
end
