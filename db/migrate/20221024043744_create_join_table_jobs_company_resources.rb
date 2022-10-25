class CreateJoinTableJobsCompanyResources < ActiveRecord::Migration[7.0]
  def change
    create_join_table :jobs, :company_resources do |t|
      t.index [:job_id, :company_resource_id]
      t.index [:company_resource_id, :job_id]
    end
  end
end
