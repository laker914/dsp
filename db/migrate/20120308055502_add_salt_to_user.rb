class AddSaltToUser < ActiveRecord::Migration
  def change
      add_column :users , :salt ,:string ,:null => false
  end
end
