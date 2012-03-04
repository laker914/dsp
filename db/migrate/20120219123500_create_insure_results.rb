class CreateInsureResults < ActiveRecord::Migration
  def change
    create_table :insure_results do |t|
      t.string :yearmonth ,:length => 8
      t.integer :emp_id
      t.string :emp_name ,:length => 30
      t.integer :company
      t.integer :hukou
      t.timestamps
    end
  end
end
