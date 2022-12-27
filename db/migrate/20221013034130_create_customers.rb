# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.index %i[email account_id], unique: true

      t.timestamps
    end
  end
end
