class AddAddressIndexToCompany < ActiveRecord::Migration
  def change
  	add_index :companies, :address_id
  end
end
