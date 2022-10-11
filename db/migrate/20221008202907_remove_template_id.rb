class RemoveTemplateId < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :template_id
  end
end
