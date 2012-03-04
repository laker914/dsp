class CreateInsurePrograms < ActiveRecord::Migration
  def change
    create_table :insure_programs do |t|
      t.string :insure_name
      t.string :py_code

      t.timestamps
    end
  end
end
