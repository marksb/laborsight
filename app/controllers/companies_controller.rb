class CompaniesController < ApplicationController
include ApplicationHelper
  def data
    center = [params[:center][:lat], params[:center][:lng]]
    distance = distance([params[:ne][:lat].to_f,params[:ne][:lng].to_f],[params[:sw][:lat].to_f,params[:sw][:lng].to_f])
    p distance
    # TODO: use lat/long to dynamically calculate distance
    box = Geocoder::Calculations.bounding_box(center, distance)
    @addresses = Address.within_bounding_box(box).includes({companies: :industry}).limit(100)
    companies = []

    @addresses.each do |address|
      address.companies.each do |company|
        company = {case_id: company.case_id,
                   id: company.id, 
                   trade_name: company.trade_name,
                   legal_name: company.legal_name,
                   letter_grade: company.assign_letter_grade,
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
                   street: address.street,
                   city: address.city,
                   state: address.state,
                   zip: address.zip,
                   latitude: address.latitude,
                   longitude: address.longitude
                   # naic_code: company.industry.naic_code,
                   # naic_code_description: company.industry.naic_code_description
                  }
        companies << company.to_json
      end
    end

    render :json => companies
  end

  def show
    @company = Company.find(params[:id])
  end

  def chart
    @company = Company.find(params[:id])
    render partial: 'chart'
  end

end

