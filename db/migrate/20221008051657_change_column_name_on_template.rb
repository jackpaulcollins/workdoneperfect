class ChangeColumnNameOnTemplate < ActiveRecord::Migration[7.0]
  def change
    rename_column :templates, :type, :template_type
  end
end
