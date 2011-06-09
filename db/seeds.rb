# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
ActiveRecord::Base.connection.execute <<SQL
COPY locations (lat, lng) FROM STDIN CSV HEADER;
SQL
File.open("#{Rails.root}/db/locations.csv") do |f|
  ActiveRecord::Base.connection.raw_connection.put_copy_data f.read
end
ActiveRecord::Base.connection.raw_connection.put_copy_end
