class ChangeJobColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :jobs, :employees_id
    create_join_table :employees, :jobs
  end
end
