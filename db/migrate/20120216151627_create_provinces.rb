class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :pcode
      t.string :pname
      t.string :py_code

      t.timestamps
    end
  end
end
