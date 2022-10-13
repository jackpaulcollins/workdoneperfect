class CreateEmployeeTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_templates do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.string :title, null: false
      t.index [:title, :account_id], unique: true
      t.timestamps
    end
  end
end
