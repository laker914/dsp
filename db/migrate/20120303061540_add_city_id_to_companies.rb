class AddCityIdToCompanies < ActiveRecord::Migration
  def change
    remove_column :companies , :province 
    remove_column :companies , :city
    remove_column :companies , :area
    add_column :companies , :city_id , :integer , :length => 11
    add_column :companies , :city_name,:string , :length => 50
  end
end
