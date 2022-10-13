class CreateEmployeeAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_attributes do |t|
      t.belongs_to :employee_template, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
