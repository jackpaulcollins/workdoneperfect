class AddClaimedByToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_reference :employees, :claimed_by, foreign_key: {to_table: :users}
    remove_index :employees, :claimed_by_id
    add_index :employees, :claimed_by_id, unique: true
  end
end
