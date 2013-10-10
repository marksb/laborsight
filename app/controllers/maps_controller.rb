class MapsController < ApplicationController
  def index
  	if cookies[:disclaimer]
  	else
  		flash[:notice] = "DISCLAIMER"
  	end
  	cookies[:disclaimer] = true
  end
end
