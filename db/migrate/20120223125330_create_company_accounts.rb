class CreateCompanyAccounts < ActiveRecord::Migration
  def change
    create_table :company_accounts do |t|
      t.integer :city_id , :length => 11
      t.string :city_name ,:length => 50
      t.integer :hukou
      t.integer :item_id
      t.decimal :fix_value,:precision => 10, :scale => 2
      t.decimal :rate,:precision => 10, :scale => 2
      t.integer :company_type
      t.decimal :company_lower,:precision => 10, :scale => 2
      t.decimal :company_limit,:precision => 10, :scale => 2
      t.integer :company_round
      t.timestamps
    end
  end
end
