require 'csv'
require 'date'

OLDEST_DATE = Date.new(2008,1,1)
sum = 0
counter = 0
CSV.foreach("fulldata.csv", {:headers => true, :header_converters => :symbol}) do |row|
  if Date.parse(row[:findings_start_date]) > OLDEST_DATE
    sum += row[:flsa_ot_bw_atp_amt].to_f
    counter += 1
  end
end

p average = sum/counter


    # company = Company.create!(case_id: row[:case_id],
    #                trade_name: row[:trade_nm],
    #                legal_name: row[:legal_name],
    #                flsa_cl_violtn_count: row[:case_violtn_cnt],
    #                flsa_cl_minor_count: row[:flsa_cl_minor_cnt],
    #                flsa_cl_cmp_assd_amt: row[:flsa_cl_cmp_assd_amt],
    #                bw_atp_amt: row[:bw_atp_amt],
    #                findings_start_date: row[:findings_start_date],
    #                findings_end_date: row[:findings_end_date],
    #                flsa_cmp_assd_amt: row[:flsa_cmp_assd_amt],
    #                flsa_repeat_violator: row[:flsa_repeat_violator],
    #                flsa_violation_count: row[:flsa_violtn_cnt],
    #                flsa_ee_atp_count: row[:flsa_ee_atp_cnt],
    #                flsa_mw_bw_atp_amt: row[:flsa_mw_bw_atp_amt],
    #                flsa_ot_bw_atp_amt: row[:flsa_ot_bw_atp_amt],
    #                flsa_15a3_bw_atp_amt: row[:flsa_bw_atp_amt],
    #                address_id: address.id,
    #                industry_id: industry.id
    #                )
