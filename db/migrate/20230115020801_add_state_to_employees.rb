class AddStateToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :state, :string
  end
end
