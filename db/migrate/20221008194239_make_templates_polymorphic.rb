class MakeTemplatesPolymorphic < ActiveRecord::Migration[7.0]
  def change
    add_column :templates, :templateable_id, :integer
    remove_column :templates, :template_attributes
    add_column :templates, :template_attributes, :string, array:true, default: []
  end
end
