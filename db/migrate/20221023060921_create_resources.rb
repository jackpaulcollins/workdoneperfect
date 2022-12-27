# frozen_string_literal: true

class CreateResources < ActiveRecord::Migration[7.0]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :description
      t.references :account, null: false, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
