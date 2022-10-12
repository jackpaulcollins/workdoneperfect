class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :employees, null: false, foreign_key: true
      t.datetime :date
      t.integer :estimated_hours
      t.integer :compeleted_hours
      t.integer :revenue

      t.timestamps
    end
  end
end
