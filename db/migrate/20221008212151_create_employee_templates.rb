class CreateEmployeeTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_templates do |t|
      t.timestamps
    end
  end
end
