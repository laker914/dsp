class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login , :null => false  
      t.string :hashed_password , :null => false
      t.string :login_name
      t.integer :sex
      t.string :email , :null => false
      t.string :login_ip
      t.string :question
      t.string :answer
      t.timestamps
    end
  end
end
