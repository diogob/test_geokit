class CreateIndexes < ActiveRecord::Migration
  def self.up
    execute "
    CREATE INDEX locations_earthdistance_ix ON locations USING gist (ll_to_earth(lat, lng));
    CREATE INDEX locations_lat_lng_ix ON locations (lat,lng);
    "
  end

  def self.down
    execute "
    DROP INDEX locations_earthdistance_ix;
    DROP INDEX locations_lat_lng_ix;
    "
  end
end
