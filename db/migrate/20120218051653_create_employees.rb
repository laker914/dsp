class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :empname, :length => 20
      t.string :empidn, :length => 20
      t.integer :sex , :length => 1
      t.string :job ,:length => 40
      t.datetime :bargain_begin
      t.datetime :bargain_end
      t.string :emp_month , :length => 2
      t.decimal :insure_base, :precision => 10, :scale => 2
      t.decimal :provident_base , :precision => 10,:scale => 2
      t.integer :hukou , :length => 1
      t.string :telphone , :length => 18
      t.string :insure_card , :length => 18
      t.string :lose_card, :length => 18
      t.integer :national ,:length => 2
      t.datetime :job_begin
      t.integer :education , :length => 2
      t.integer :company , :length => 11
      t.string :py_code, :length => 100
      t.integer :is_insure , :length => 1
      t.integer :is_provident, :length => 1
      t.string :c_method, :length => 20
      t.timestamps
    end
  end
end
