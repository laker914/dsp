class CreateInfomations < ActiveRecord::Migration
  def change
    create_table :infomations do |t|
      t.string :open_bank
      t.string :bank_account
      t.string :company

      t.timestamps
    end
  end
end
