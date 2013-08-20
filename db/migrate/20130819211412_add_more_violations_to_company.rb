class AddMoreViolationsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :mspa_violtn_cnt, :integer
    add_column :companies, :mspa_bw_atp_amt, :float
    add_column :companies, :mspa_ee_atp_cnt, :integer
    add_column :companies, :mspa_cmp_assd_amt, :float
    add_column :companies, :fmla_violtn_cnt, :integer
    add_column :companies, :fmla_bw_atp_amt, :float
    add_column :companies, :fmla_ee_atp_cnt, :integer
    add_column :companies, :fmla_cmp_assd_amt, :float
    add_column :companies, :h1b_violtn_cnt, :integer
    add_column :companies, :h1b_bw_atp_amt, :integer
    add_column :companies, :h1b_ee_atp_cnt, :integer
    add_column :companies, :h1b_cmp_assd_amt, :float
  end
end
