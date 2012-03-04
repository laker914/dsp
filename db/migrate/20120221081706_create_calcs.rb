class CreateCalcs < ActiveRecord::Migration
  def change
    create_table :calcs do |t|
      t.string :company , :null => false
      t.string :yearmonth ,:length => 6 , :null => false
      t.timestamps
    end
  end
end
