require 'pg'
def setup_test_database

  p "Setting up test database..."

  connection = PG.connect(dbname: 'makersbnb')

  connection.exec("TRUNCATE bookings;")
end
