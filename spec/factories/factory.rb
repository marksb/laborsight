FactoryGirl.define do
  factory :company do

    case_id 1234567
    trade_name "Priya's Place"
    legal_name "Priya Inc."

    flsa_cl_violtn_count 0
    flsa_cl_minor_count  0
    flsa_cl_cmp_assd_amt 0
    flsa_cmp_assd_amt    0

    findings_start_date  "2010-01-14 00:00:00"
    findings_end_date    "2012-01-13 00:00:00"

    flsa_repeat_violator "N/A"
    flsa_violation_count 0
    flsa_ee_atp_count    0
    bw_atp_amt           0
    flsa_mw_bw_atp_amt   0
    flsa_ot_bw_atp_amt   0
    flsa_15a3_bw_atp_amt 0
    mspa_violtn_cnt 0
    mspa_bw_atp_amt 0
    mspa_ee_atp_cnt 0
    mspa_cmp_assd_amt 0
    fmla_violtn_cnt 0
    fmla_bw_atp_amt 0
    fmla_ee_atp_cnt 0
    fmla_cmp_assd_amt 0
    h1b_violtn_cnt 0
    h1b_bw_atp_amt 0
    h1b_ee_atp_cnt 0
    h1b_cmp_assd_amt 0
  end
end
