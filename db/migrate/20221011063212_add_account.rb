class AddAccount < ActiveRecord::Migration[7.0]
  def change
    add_reference :accounts, :customer, index: :true
    add_reference :accounts, :job, index: :true
  end
end
