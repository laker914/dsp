class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :ccode , :null  => false 
      t.string :ccname , :null => false
      t.string :caddress , :null => false  ,:limit => 200
      t.string :contact 
      t.string :job
      t.string :phone
      t.string :telphone
      t.string :fax
      t.string :province , :null => false
      t.string :city ,:null => false
      t.string :area,:null => false
      t.string :py_code,:null => false
      t.string :c_method,:null => false
      t.string :org_code,:null => false
      t.string :c_type,:null => false
      t.decimal :insure_base, :precision => 18, :scale => 2
      t.decimal :provident_base, :precision => 18, :scale => 2
      t.timestamps
    end
  end
end
