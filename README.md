# Benchmarks of geokit-rails3 vs activerecord-postgres-earthdistance

  To run the benchmarks first install the environment:

    * git clone git://github.com/diogob/test_geokit.git
    * bundle install
    * edit config/database.yml
    * rake db:create
    * rake db:migrate

  Then run the benchmarks:

    * bundle exec rails runner script/benchmarks.rb

  And the results will be logged to log/development.log

