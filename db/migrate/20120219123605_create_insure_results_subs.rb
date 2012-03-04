class CreateInsureResultsSubs < ActiveRecord::Migration
  def change
    create_table :insure_results_subs do |t|
      t.integer :main_id
      t.integer :insure_type
      t.decimal :insure_base , :precision => 10, :scale => 2
      t.decimal :insure_money, :precision => 10, :scale => 2
      t.integer :insure_item
      t.timestamps
    end
  end
end
