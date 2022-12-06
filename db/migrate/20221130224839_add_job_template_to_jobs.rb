class AddJobTemplateToJobs < ActiveRecord::Migration[7.0]
  def change
    add_reference :jobs, :job_template, index: true
  end
end
