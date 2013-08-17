#encoding: utf-8
class MapsController < ApplicationController

  def index
    @company = {name: "DBC",
                address: "351 West Hubbard, Chicago, IL",
                latitde: 41.890011,
                longitude: -87.637280}.to_json
  #TODO: Incorporate with map
		# context = GOV::DataContext.new API_HOST, API_KEY, API_SECRET, API_DATA, API_URI
  #   request = GOV::DataRequest.new context
  #   @companies = []
  #   request.call_api API_DATA, select: 'companyandlocation' do |results, error|
  #     if error
  #       @error = error
  #     else
  #       @companies = results
  #     end
  #   end
  #   request.wait_until_finished
  end
end
