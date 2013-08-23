class CompaniesController < ApplicationController
include ApplicationHelper
  def data
    companies = [] 
    addresses = Address.within_bounding_box(get_box).includes(:companies).limit(1000)

    addresses.each do |address|
      address.companies.each { |company| companies << company.to_json }
    end

    render :json => companies
  end

  def neighborhood
    grade = Address.where(zip: params[:zip]).first.assign_neighborhood_grade
    neighborhood = {neighborhood: params[:neighborhood], grade: grade}.to_json
    
    render :json => neighborhood
  end

  def show
    @company = Company.find(params[:id])
  end

  def chart_industry
    @company = Company.find(params[:id])
    render partial: 'chart_industry'
  end

  def chart_local
    @company = Company.find(params[:id])
    render partial: 'chart_local'
  end

  def chart_national
    @company = Company.find(params[:id])
    render partial: 'chart_national'
  end

end

