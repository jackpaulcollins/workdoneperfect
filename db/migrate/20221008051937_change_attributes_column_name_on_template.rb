class ChangeAttributesColumnNameOnTemplate < ActiveRecord::Migration[7.0]
  def change
    rename_column :templates, :attributes, :template_attributes

  end
end
