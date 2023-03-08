class AddHourlyRateToJobTemplates < ActiveRecord::Migration[7.0]
  def change
    add_column :job_templates, :hourly_rate, :float
  end
end
