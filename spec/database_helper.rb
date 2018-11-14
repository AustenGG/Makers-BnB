require 'pg'

def persisted_data(available:)
  connection = PG.connect(dbname: 'makersbnb_test')

  connection.query("SELECT * FROM bookings WHERE available = #{available};")

end
