# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :customer, null: false, foreign_key: true
      t.datetime :date_and_time, null: false
      t.float :estimated_hours
      t.float :total_hours
      t.float :revenue

      t.timestamps
    end
  end
end
