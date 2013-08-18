class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :default_city
      t.string :default_state
      
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
