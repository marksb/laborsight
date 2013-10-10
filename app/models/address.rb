require 'grade'

class Address < ActiveRecord::Base
  include Grade

  has_many :companies

  validates_presence_of :street, :city, :state, :zip, :latitude, :longitude

  validates_inclusion_of :zip, :in => 00001..99999

  validates_length_of :state, :is => 2

  attr_accessible :street, :city, :state, :zip, :latitude, :longitude

  geocoded_by :full_street_address
  before_validation :geocode

  def full_street_address
    [street, city, state, 'US'].compact.join(', ')
  end

  def neighborhood_addresses
    Address.where(zip: self.zip)
  end

  def assign_neighborhood_rating
    sum = 0

    Address.where(zip: self.zip).each do |address|
      address.companies.each do |company|
        sum += company.calculate_rating
      end
    end

    average = sum.to_f/neighborhood_addresses.count
  end

#TODO: Refactor so this use the function in the module
  def assign_neighborhood_grade
    case assign_neighborhood_rating
      when 90..100
        "A"
      when 80..89
        "B"
      when 70..79
        "C"
      when 60..69
        "D"
      when 0..59
        "F"
    end
  end

end
