desc "Cache warmer"

task :warm_cache => :environment do

  puts "Caching national stats"
  Company.first.fmla_violtn_cnt_national
  Company.first.flsa_cl_violtn_cnt_national
  Company.first.h1b_violtn_cnt_national


  puts "Caching industry stats"
  Industry.all.each do |industry|
    industry.fmla_count
    industry.cl
    industry.h1b_violtn_cnt
  end

  puts "POSI VIBES -daddy"
end
