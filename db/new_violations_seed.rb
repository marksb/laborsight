require 'csv'
puts "Opening up the CSV..."
CSV.foreach("fulldata.csv", {:headers => true, :header_converters => :symbol}) do |row|
  company = Company.find_by_case_id(row[:case_id])
  next if company == nil
  company.update_attributes(
    mspa_violtn_cnt: row[:mspa_violtn_cnt], #Violations found under MSPA (Migrant and Seasonal Agricultural Worker Protection Act)
    mspa_bw_atp_amt: row[:mspa_bw_atp_amt], #BW Agreed to under MSPA (Migrant and Seasonal Agricultural Worker Protection Act)
    mspa_ee_atp_cnt: row[:mspa_ee_atp_cnt], #EE's Agreed to under MSPA (Migrant and Seasonal Agricultural Worker Protection Act)
    mspa_cmp_assd_amt: row[:mspa_cmp_assd_amt], #CMP's assessed under MSPA (Migrant and Seasonal Agricultural Worker Protection Act)
    fmla_violtn_cnt: row[:fmla_violtn_cnt], #Violations found under FMLA (Family and Medical Leave Act)
    fmla_bw_atp_amt: row[:fmla_bw_atp_amt], #BW Agreed to under FMLA (Family and Medical Leave Act)
    fmla_ee_atp_cnt: row[:fmla_ee_atp_cnt], #EE's Agreed to under FMLA (Family and Medical Leave Act)
    fmla_cmp_assd_amt: row[:fmla_cmp_assd_amt], #CMP's assessed under FMLA (Family and Medical Leave Act)
    h1b_violtn_cnt: row[:h1b_violtn_cnt], #Violations found under H1A (Work Visa - Registered nurses for temporary employment)
    h1b_bw_atp_amt: row[:h1b_bw_atp_amt], #BW Agreed to under H1B (Work Visa - Speciality Occupations)
    h1b_ee_atp_cnt: row[:h1b_ee_atp_cnt], #EE's Agreed to under H1A (Work Visa - Registered nurses for temporary employment)
    h1b_cmp_assd_amt: row[:h1b_cmp_assd_amt] #CMP's assessed under H1B (Work Visa - Speciality Occupations)
    )
end
