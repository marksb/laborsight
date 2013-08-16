class CreateIndustries < ActiveRecord::Migration
  def up
    create_table :industries do |t|
      t.integer   :naic_code
      t.string    :naic_code_description

      t.timestamps
    end
  end

  def down
    drop_table :industries
  end
end
