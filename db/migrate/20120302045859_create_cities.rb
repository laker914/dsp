class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name 
      t.integer :parent_id , :length => 11
      t.integer :lft , :length => 11
      t.integer :rgt , :length  => 11
      t.timestamps
    end
  end
end
