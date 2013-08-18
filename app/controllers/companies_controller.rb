class CompaniesController < ApplicationController

  def data
    center = [params[:center][:lat], params[:center][:lng,]]
    box = Geocoder::Calculations.bounding_box(center, 200)
    @addresses = Address.within_bounding_box(box)
    #@addresses = Address.includes({companies: :industry})
    companies = []

    @addresses.each do |address|
      address.companies.each do |company|
        company = {case_id: company.case_id,
                   trade_name: company.trade_name,
                   legal_name: company.legal_name,
                   flsa_cl_violtn_count: company.flsa_cl_violtn_count,
                   flsa_cl_minor_count: company.flsa_cl_minor_count,
                   flsa_cl_cmp_assd_amt: company.flsa_cl_cmp_assd_amt,
                   bw_atp_amt: company.bw_atp_amt,
                   findings_start_date: company.findings_start_date,
                   findings_end_date: company.findings_end_date,
                   flsa_cmp_assd_amt: company.flsa_cmp_assd_amt,
                   flsa_repeat_violator: company.flsa_repeat_violator,
                   flsa_violation_count: company.flsa_violation_count,
                   flsa_ee_atp_count: company.flsa_ee_atp_count,
                   flsa_mw_bw_atp_amt: company.flsa_mw_bw_atp_amt,
                   flsa_ot_bw_atp_amt: company.flsa_ot_bw_atp_amt,
                   flsa_15a3_bw_atp_amt: company.flsa_15a3_bw_atp_amt,
                   street: company.address.street,
                   city: company.address.city,
                   state: company.address.state,
                   zip: company.address.zip,
                   latitude: company.address.latitude,
                   longitude: company.address.longitude,
                   naic_code: company.industry.naic_code,
                   naic_code_description: company.industry.naic_code_description
                  }
        companies << company.to_json
      end
    end

    render :json => companies
  end

  def show

  end
end

