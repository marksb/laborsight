class Industry < ActiveRecord::Base
  has_many :companies

  validates_presence_of :naic_code, :naic_code_description
  validates_uniqueness_of :naic_code, :naic_code_description
  validates_inclusion_of :naic_code, :in => 1000..9999999
  validates_numericality_of :naic_code

  attr_accessible :naic_code, :naic_code_description

  def fmla_count
    Rails.cache.fetch "industry/fmla_count/#{self.id}" do
      avg_penalty = []
      companies.order("fmla_violtn_cnt ASC").each do |company|
        avg_penalty << company.fmla_violtn_cnt
      end
      median(avg_penalty)
    end
  end

  def cl
    Rails.cache.fetch "industry/cl/#{self.id}" do
      avg_penalty = []
      companies.order("flsa_cl_violtn_count ASC").each do |company|
        avg_penalty << company.flsa_cl_violtn_count
      end
      median(avg_penalty)
    end
  end

  def h1b_violtn_cnt
    Rails.cache.fetch "indsutry/h1b_violtn_cnt/#{self.id}" do
      total_penalties = []
      companies.order("h1b_violtn_cnt ASC").each do |company|
        total_penalties << company.h1b_violtn_cnt
      end
      median(total_penalties)
    end
  end

  # TODO: move to module
  def median(array)
    return (array[(array.count - 1) / 2] + array[array.count / 2]) / 2.0
  end
end
