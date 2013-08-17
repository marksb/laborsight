class CreateAddresses < ActiveRecord::Migration
  def up
    create_table :addresses do |t|
      t.string  :street
      t.string  :city
      t.string  :state
      t.integer :zip
      t.float :latitude
      t.float :longitude
    end
  end

  def down
    drop_table :addresses
  end
end
