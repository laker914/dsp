class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tcode
      t.string :tvalue
      t.string :tname
      t.integer :default

      t.timestamps
    end
  end
end
