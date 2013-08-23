require 'grade'

class Company < ActiveRecord::Base
  include Grade

  belongs_to :industry
  belongs_to :address

  validates_presence_of :case_id, :trade_name

  validates_numericality_of :flsa_cl_violtn_count, :flsa_cl_minor_count, :flsa_cl_cmp_assd_amt, :flsa_cmp_assd_amt,
                            :flsa_violation_count, :flsa_ee_atp_count, :bw_atp_amt,
                            :flsa_mw_bw_atp_amt, :flsa_ot_bw_atp_amt, :flsa_15a3_bw_atp_amt, :mspa_violtn_cnt, :mspa_bw_atp_amt,
                            :mspa_ee_atp_cnt, :mspa_cmp_assd_amt, :fmla_violtn_cnt, :fmla_bw_atp_amt, :fmla_ee_atp_cnt, :fmla_cmp_assd_amt,
                            :h1b_violtn_cnt, :h1b_bw_atp_amt, :h1b_ee_atp_cnt, :h1b_cmp_assd_amt, allow_nil: true

  attr_accessible :case_id, :trade_name, :legal_name, :flsa_cl_violtn_count, :flsa_cl_minor_count, :flsa_cl_cmp_assd_amt,
                  :flsa_cmp_assd_amt, :findings_start_date, :findings_end_date, :flsa_repeat_violator, :flsa_violation_count,
                  :flsa_ee_atp_count, :bw_atp_amt, :flsa_mw_bw_atp_amt, :flsa_ot_bw_atp_amt, :flsa_15a3_bw_atp_amt, :address_id,
                  :industry_id, :mspa_violtn_cnt, :mspa_bw_atp_amt, :mspa_ee_atp_cnt, :mspa_cmp_assd_amt, :fmla_violtn_cnt, :fmla_bw_atp_amt,
                  :fmla_ee_atp_cnt, :fmla_cmp_assd_amt, :h1b_violtn_cnt, :h1b_bw_atp_amt, :h1b_ee_atp_cnt, :h1b_cmp_assd_amt


  def fmla_violtn_cnt_national
    Rails.cache.fetch "national/fmla_violtn_cnt" do
      median(Company.pluck(:fmla_violtn_cnt))
    end
  end

  def flsa_cl_violtn_cnt_national
    Rails.cache.fetch "national/flsa_cl_violtn_cnt" do
      median(Company.pluck(:flsa_cl_violtn_count))
    end
  end

  def h1b_violtn_cnt_national
    Rails.cache.fetch "national/h1b_violtn_cnt" do
      median(Company.pluck(:h1b_violtn_cnt))
    end
  end

  def fmla_violtn_cnt_local
    # do not cache
  end

  def flsa_cl_violtn_cnt_local
    # do not cache
  end

  def h1b_violtn_cnt_local
    # do not cache
  end

  def fmla_count_by_industry
    industry.fmla_count
  end

  def avg_cl_by_industry
    industry.cl
  end

  def avg_h1b_by_industry
    industry.h1b_violtn_cnt
  end

  # TODO: move to module
  def median(array)
    return (array[(array.count - 1) / 2] + array[array.count / 2]) / 2.0
  end

  def as_json(options={})
    {id: id, 
     street: address.street, 
     city: address.city, 
     state: address.state, 
     zip: address.zip, 
     longitude: address.longitude,
     latitude: address.latitude }
  end

end
