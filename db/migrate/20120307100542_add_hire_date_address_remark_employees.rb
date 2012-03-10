class AddHireDateAddressRemarkEmployees < ActiveRecord::Migration
  def up
    add_column :employees , :hire_date , :datetime ,:null => false
    add_column :employees , :address , :string ,:length => 100
    add_column :employees , :remark , :string
  end

  def down
    remove_column :employees , :hire_date 
    remove_column :employees , :address
    remove_column :employees , :remark
  end
end
