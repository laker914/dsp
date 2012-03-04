class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :acode
      t.string :aname
      t.string :py_code
      t.string :parent

      t.timestamps
    end
  end
end
