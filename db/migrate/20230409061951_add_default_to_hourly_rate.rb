class AddDefaultToHourlyRate < ActiveRecord::Migration[7.0]
  def change
    change_column :job_templates, :hourly_rate, :float, default: 0.0
  end
end
