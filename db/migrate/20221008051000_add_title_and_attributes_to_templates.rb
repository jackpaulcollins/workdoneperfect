class AddTitleAndAttributesToTemplates < ActiveRecord::Migration[7.0]
  def change
    add_column :templates, :title, :string
    add_column :templates, :attributes, :json
  end
end
