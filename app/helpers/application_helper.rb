module ApplicationHelper

  def distance(loc1, loc2)
    lat1, lon1 = loc1
    lat2, lon2 = loc2
    dLat = (lat2-lat1).to_rad
    dLon = (lon2-lon1).to_rad
    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(lat1.to_rad) * Math.cos(lat2.to_rad) *
        Math.sin(dLon/2) * Math.sin(dLon/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    3959 * c 
  end

  def center
    [params[:center][:lat], params[:center][:lng]]
  end

  def get_box
    dist = distance([params[:ne][:lat].to_f, params[:ne][:lng].to_f],
                    [params[:sw][:lat].to_f, params[:sw][:lng].to_f])
    Geocoder::Calculations.bounding_box(center, dist)
  end
end

class Numeric
  def to_rad
    self * Math::PI / 180
  end
end
