class AddEmailCompanies < ActiveRecord::Migration
  def up
    add_column :companies , :email ,:string , :length => 30
  end

  def down
    remove_column :companies , :email 
  end
end
