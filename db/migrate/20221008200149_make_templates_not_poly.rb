class MakeTemplatesNotPoly < ActiveRecord::Migration[7.0]
  def change
    remove_column :templates, :templateable_id
  end
end
