class MapsController < ApplicationController
  include Dol
  def index
  	flash[:notice] = "DISCLAIMER" unless cookies[:disclaimer]
  	cookies[:disclaimer] = true
  	context = GOV::DataContext.new(SECRETS['gov']['api_host'],
                                   SECRETS['gov']['api_key'],
                                   SECRETS['gov']['api_secret'],
                                   SECRETS['gov']['api_data'],
                                   SECRETS['gov']['api_uri'])

  	request = GOV::DataRequest.new context

    @results = by_zipcode request
  end
end
