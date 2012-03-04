class CreatePersonalAccounts < ActiveRecord::Migration
  def change
    create_table :personal_accounts do |t|
      t.integer :city_id  ,:length => 11
      t.string  :city_name ,:length => 50
      t.integer :item_id,:null => false
      t.integer :hukou,:null => false
      t.decimal :fix_value,:precision => 10, :scale => 2
      t.decimal :rate,:precision => 10, :scale => 2
      t.integer :personal_type
      t.decimal :personal_limit,:precision => 10, :scale => 2
      t.decimal :personal_lower,:precision => 10, :scale => 2
      t.integer :personal_round
      t.timestamps
    end
  end
end
