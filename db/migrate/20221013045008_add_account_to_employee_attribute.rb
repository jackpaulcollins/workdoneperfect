class AddAccountToEmployeeAttribute < ActiveRecord::Migration[7.0]
  def change
    add_reference :employee_attributes, :account, index: true
  end
end
