class AddRmbCompanies < ActiveRecord::Migration
  def up
      add_column :companies , :rmb , :decimal ,:precision => 18, :scale => 2 
  end

  def down
    remove_column :companies , :rmb
  end
end
