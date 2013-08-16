class CreateCompanies < ActiveRecord::Migration
  def up
    create_table :companies do |t|
      t.integer    :case_id
      t.string     :trade_name
      t.string     :legal_name

      t.integer    :flsa_cl_violtn_count # violations found under FLSA for child labor
      t.integer    :flsa_cl_minor_count  # minors found employed in violation of FLSA
      t.float      :flsa_cl_cmp_assd_amt # civil monetary penalties assessed under FLSA for child labor
      t.float      :flsa_cmp_assd_amt    # civil monetary penalties assessed under FLSA (Fair Labor Standards Act)

      t.timestamp  :findings_start_date  # date where WHD determined that findings first occurred
      t.timestamp  :findings_end_date    # date where WHD determined that findings last occurred

      t.string     :flsa_repeat_violator # r=repeat; w=willful; rw=repeat and willful
      t.integer    :flsa_violation_count # total EE's employed in violation
      t.integer    :flsa_ee_atp_count    # EE's agreed to under FLSA (Fair Labor Standards Act)
      t.float      :bw_atp_amt           # total backwages agreed to pay
      t.float      :flsa_mw_bw_atp_amt   # backwages for minimum wages
      t.float      :flsa_ot_bw_atp_amt   # backwages for overtime
      t.float      :flsa_15a3_bw_atp_amt # backwages for 15 (a)(3)

      t.belongs_to :address
      t.belongs_to :industry
      t.timestamps
    end
  end

  def down
    drop_table :companies
  end
end
