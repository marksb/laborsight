require 'spec_helper'

describe Company do

  it { should validate_presence_of(:case_id) }
  it { should validate_presence_of(:trade_name) }

  must_be_digit = [:flsa_cl_violtn_count, :flsa_cl_minor_count, :flsa_cl_cmp_assd_amt, :flsa_cmp_assd_amt, 
                   :flsa_repeat_violator, :flsa_violation_count, :flsa_ee_atp_count, :bw_atp_amt, :flsa_mw_bw_atp_amt, 
                   :flsa_ot_bw_atp_amt, :flsa_15a3_bw_atp_amt]
 
  must_be_digit.each { | elem | it { should validate_numericality_of(elem) } }

  mass_assignable = [:case_id, :trade_name, :legal_name, :flsa_cl_violtn_count, :flsa_cl_minor_count, :flsa_cl_cmp_assd_amt, 
                     :flsa_cmp_assd_amt, :findings_start_date, :findings_end_date, :flsa_repeat_violator, :flsa_violation_count, 
                     :flsa_ee_atp_count, :bw_atp_amt, :flsa_mw_bw_atp_amt, :flsa_ot_bw_atp_amt, :flsa_15a3_bw_atp_amt]

  mass_assignable.each { | elem | it { should allow_mass_assignment_of(elem) } }

end
