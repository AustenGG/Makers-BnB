require 'pg'

class Booking

  def self.date_list
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec('SELECT Date FROM bookings')
    result.map { |bookings| bookings['Date'] }
  end

  def self.location_list
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
  end

    result = connection.exec('SELECT Location FROM bookings')
    result.map { |bookings| bookings['Location'] }
  end

end
