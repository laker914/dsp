class AddRmbMyInfomation < ActiveRecord::Migration
  def up
    add_column :infomations , :rmb , :decimal ,:precision => 18, :scale => 2 , :default => 50
  end

  def down
    remove_column :infomations , :rmb
  end
end
