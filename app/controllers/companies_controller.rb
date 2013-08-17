class CompaniesController < ApplicationController

  def data
    params[:lat]
    params[:lng]

    @addresses = Address.all

    companies = []

    @addresses.each do |address|
      address.companies.each do |company|
        company = {case_id: company.case_id,
                   trade_name: company.trade_name,
                   street: company.address.street,
                   city: company.address.city,
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

