class RenameTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :company_resources_jobs, :resource_schedules
    add_column :resource_schedules, :job_date, :date
    add_index :resource_schedules, ["company_resource_id", "job_id", "job_date"], unique: true, name: "company_resource_job_schedule"
  end
end
