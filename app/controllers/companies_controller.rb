class CompaniesController < ApplicationController

  def data
    params[:lat]
    params[:lng]

    @addresses = Address.all

    companies = []
    @addresses.each do |add|
      companies << add.to_json
    end
    render :json => companies
  end

  def show

  end
end

