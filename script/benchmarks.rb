def test_creation
  ActiveRecord::Base.connection.execute "TRUNCATE locations;"
  ActiveRecord::Base.connection.execute <<SQL
COPY locations (lat, lng) FROM STDIN CSV HEADER;
SQL
  File.open("#{Rails.root}/db/locations.csv") do |f|
    ActiveRecord::Base.connection.raw_connection.put_copy_data f.read
  end
  ActiveRecord::Base.connection.raw_connection.put_copy_end
end

def test_sequence_of_queries_with_geokit
  Location.benchmark("query geokit") do
    (1..1000).each do |radius|
      Location.within(radius, :origin => [-30.0277041, -51.2287346]).all
    end
    (1..1000).each do |radius|
      Location.within(radius, :origin => [0, 0]).all
    end
  end
end

def test_sequence_of_queries_with_earthdistance
  Location.benchmark("query earthdistance") do
    (1..1000).each do |radius|
      Location.within_radius(radius, -30.0277041, -51.2287346).all
    end
    (1..1000).each do |radius|
      Location.within_radius(radius, 0, 0).all
    end
  end
end
test_creation
test_sequence_of_queries_with_geokit
test_sequence_of_queries_with_earthdistance
