# frozen_string_literal: true

class JobTemplate < ActiveRecord::Migration[7.0]
  def change
    create_table :job_templates do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.string :title, null: false
      t.boolean :default_template, default: false
      t.index %i[title account_id], unique: true

      t.timestamps
    end

    create_table :job_attributes do |t|
      t.belongs_to :job_template, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :data_type, null: false

      t.timestamps
    end
  end
end
