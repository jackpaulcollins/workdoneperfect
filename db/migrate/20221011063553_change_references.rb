class ChangeReferences < ActiveRecord::Migration[7.0]
  def change
    remove_reference :accounts, :customer
    remove_reference :accounts, :job
  end
end
