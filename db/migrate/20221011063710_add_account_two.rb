class AddAccountTwo < ActiveRecord::Migration[7.0]
  def change
    add_reference :customers, :account, index: :true
    add_reference :jobs, :account, index: :true
  end
end
