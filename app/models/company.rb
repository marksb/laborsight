require 'grade'

class Company < ActiveRecord::Base
  include Grade

  belongs_to :industry
  belongs_to :address

  validates_presence_of :case_id, :trade_name

  validates_numericality_of :flsa_cl_violtn_count, :flsa_cl_minor_count, :flsa_cl_cmp_assd_amt, :flsa_cmp_assd_amt,
                            :flsa_violation_count, :flsa_ee_atp_count, :bw_atp_amt,
                            :flsa_mw_bw_atp_amt, :flsa_ot_bw_atp_amt, :flsa_15a3_bw_atp_amt, allow_nil: true

  attr_accessible :case_id, :trade_name, :legal_name, :flsa_cl_violtn_count, :flsa_cl_minor_count, :flsa_cl_cmp_assd_amt,
                  :flsa_cmp_assd_amt, :findings_start_date, :findings_end_date, :flsa_repeat_violator, :flsa_violation_count,
                  :flsa_ee_atp_count, :bw_atp_amt, :flsa_mw_bw_atp_amt, :flsa_ot_bw_atp_amt, :flsa_15a3_bw_atp_amt, :address_id,
                  :industry_id, :mspa_violtn_cnt, :mspa_bw_atp_amt, :mspa_ee_atp_cnt, :mspa_cmp_assd_amt, :fmla_violtn_cnt, :fmla_bw_atp_amt,
                  :fmla_ee_atp_cnt, :fmla_cmp_assd_amt, :h1b_violtn_cnt, :h1b_bw_atp_amt, :h1b_ee_atp_cnt, :h1b_cmp_assd_amt
end
