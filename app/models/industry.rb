class Industry < ActiveRecord::Base
  validates_presence_of :naic_code, :naic_code_description
  validates_uniqueness_of :naic_code, :naic_code_description
  validates_inclusion_of :naic_code, :in => 1000..9999999
  validates_numericality_of :naic_code

  attr_accessible :naic_code, :naic_code_description
end