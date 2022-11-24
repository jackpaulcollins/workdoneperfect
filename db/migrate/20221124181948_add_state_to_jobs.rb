class AddStateToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :completed_at, :datetime
  end
end
