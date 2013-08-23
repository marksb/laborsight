class AddIndexToCompanyIndustryId < ActiveRecord::Migration
  def change
    add_index :companies, :industry_id
  end
end
