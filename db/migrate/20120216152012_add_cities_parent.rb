class AddCitiesParent < ActiveRecord::Migration
  def up
     add_column :cities , :parent , :string
  end

  def down
      remove_column :cities , :parent
  end
end
