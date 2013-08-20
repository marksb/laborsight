desc "add additional columns to the database"
task :add_seeds => :environment do
  require File.join(Rails.root, '/db/new_violations_seed')
  puts "Seeding the database..."
end
