class RemoveCreatedById < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :user_id
  end
end
