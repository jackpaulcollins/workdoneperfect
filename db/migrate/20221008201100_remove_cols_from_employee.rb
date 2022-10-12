class RemoveColsFromEmployee < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :driver
    rename_column :employees, :position, :title
    add_column :employees, :termination_date, :date
    add_column :employees, :attributes_from_template, :json
    add_reference :employees, :template, index: true
  end
end
