module Dol
  def save_company(company)
 	  new_company = Company.create(
		:trade_name  								=> company['trade_nm'],
		:findings_start_date 						=> company['findings_start_date'],
		:findings_end_date                          => company['findings_end_date'],
		:flsa_violation_count                       => company['flsa_violtn_cnt'],
		:flsa_ee_atp_count                          => company['flsa_ee_atp_cnt'],
		:flsa_repeat_violator                       => company['flsa_repeat_violator'],
		:flsa_ot_bw_atp_amt 						=> company['flsa_ot_bw_atp_amt'],
		:flsa_mw_bw_atp_amt 						=> company['flsa_mw_bw_atp_amt'],
		:flsa_15a3_bw_atp_amt 						=> company['flsa_15a3_bw_atp_amt'],
		:bw_atp_amt 								=> company['flsa_bw_atp_amt'],
		:flsa_cmp_assd_amt 							=> company['flsa_cmp_assd_amt'],
		:flsa_cl_violtn_count 						=> company['flsa_cl_violtn_cnt'],
		:flsa_cl_minor_count 						=> company['flsa_cl_minor_count'],
		:flsa_cl_cmp_assd_amt 						=> company['flsa_cl_cmp_assd_amt'],
		:industry_id								=> Industry.where(naic_code: company['naic_cd']).first.id,
		)
end




# street_addr_1_txt	Employer Street Address	varchar(255)
# city_nm	City Name	varchar(75)
# st_cd	Employer State	varchar(8)
# zip_cd	Employer Zip Code	varchar(8)


def save_address(company)
	address = Address.new(
	  	:address 									=> company['street_addr_1_txt'],
		:city 										=> company['city_nm'],
		:state 										=> company['st_cd'],
		:zip 										=> company['zip_cd']
	)
	address.save
end

  def by_zipcode request
  	temp = []
	 	request.call_api 'Compliance/WHD/full', :filter => "zip_cd eq '48167'", :orderby => 'trade_nm' do |results, error|
		  if error
		    p error
		  else
		    results.each { |n| save_company(n) }
		  end
		  temp << results
		end
	  request.wait_until_finished

	  temp
  end
end