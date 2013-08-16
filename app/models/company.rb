class Company < ActiveRecord::Base

  validates_presence_of :case_id, :trade_name

  validates_numericality_of :flsa_cl_violtn_count, :flsa_cl_minor_count, :flsa_cl_cmp_assd_amt, :flsa_cmp_assd_amt, 
                            :flsa_repeat_violator, :flsa_violation_count, :flsa_ee_atp_count, :bw_atp_amt, 
                            :flsa_mw_bw_atp_amt, :flsa_ot_bw_atp_amt, :flsa_15a3_bw_atp_amt, allow_nil: true

  attr_accessible :case_id, :trade_name, :legal_name, :flsa_cl_violtn_count, :flsa_cl_minor_count, :flsa_cl_cmp_assd_amt, 
                  :flsa_cmp_assd_amt, :findings_start_date, :findings_end_date, :flsa_repeat_violator, :flsa_violation_count, 
                  :flsa_ee_atp_count, :bw_atp_amt, :flsa_mw_bw_atp_amt, :flsa_ot_bw_atp_amt, :flsa_15a3_bw_atp_amt
end