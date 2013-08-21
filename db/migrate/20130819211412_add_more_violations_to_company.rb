class AddMoreViolationsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :mspa_violtn_cnt, :integer #Violations found under MSPA (Migrant and Seasonal Agricultural Worker Protection Act)
    add_column :companies, :mspa_bw_atp_amt, :float #BW Agreed to under MSPA (Migrant and Seasonal Agricultural Worker Protection Act)
    add_column :companies, :mspa_ee_atp_cnt, :integer #EE's Agreed to under MSPA (Migrant and Seasonal Agricultural Worker Protection Act)
    add_column :companies, :mspa_cmp_assd_amt, :float #CMP's assessed under MSPA (Migrant and Seasonal Agricultural Worker Protection Act)  
    add_column :companies, :fmla_violtn_cnt, :integer #BW Agreed to under FMLA (Family and Medical Leave Act)
    add_column :companies, :fmla_bw_atp_amt, :float #BW Agreed to under FMLA (Family and Medical Leave Act)
    add_column :companies, :fmla_ee_atp_cnt, :integer #EE's Agreed to under FMLA (Family and Medical Leave Act)
    add_column :companies, :fmla_cmp_assd_amt, :float #CMP's assessed under FMLA (Family and Medical Leave Act)
    add_column :companies, :h1b_violtn_cnt, :integer #Violations found under H1B (Work Visa - Speciality Occupations)
    add_column :companies, :h1b_bw_atp_amt, :integer #BW Agreed to under H2A (Work Visa - Seasonal Agricultural Workers)
    add_column :companies, :h1b_ee_atp_cnt, :integer #EE's Agreed to under H2A (Work Visa - Seasonal Agricultural Workers)  
    add_column :companies, :h1b_cmp_assd_amt, :float #CMP's assessed under H2A (Work Visa - Seasonal Agricultural Workers)
  end
end
