# frozen_string_literal: true

# This migration comes from pay (originally 20170727235816)
class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :pay_charges do |t|
      t.references :owner
      t.string :processor, null: false
      t.string :processor_id, null: false
      t.integer :amount, null: false
      t.integer :amount_refunded
      t.string :card_type
      t.string :card_last4
      t.string :card_exp_month
      t.string :card_exp_year

      t.timestamps
    end
  end
end
