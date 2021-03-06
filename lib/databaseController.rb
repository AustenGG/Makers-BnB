require 'pg'

class Database
  def initialize
    p "Database Initialize!"
    @connection = PG.connect(dbname: 'makersbnb')
  end

  def verifyLogin(userEmail, userPass)
    userData = getUserData(userEmail)
    if userData.num_tuples.zero?
      false
    else
      userData = userData[0]
      if (userPass == userData["password"])
        true
      else
        false
      end
    end
  end

  def makeBooking(userid, locationid, startdate, enddate)
    insert = ("INSERT INTO bookings (lodgerid, locationid, startdate, enddate) VALUES ('#{userid}','#{locationid}','#{startdate}','#{enddate}')")
    update = ("UPDATE locations SET availability=1 WHERE locationid='#{locationid}'")
    begin
      @connection.exec(insert)
      @connection.exec(update)
      return true
    rescue => exception
      return false
    end
  end

  def getUsersBookings(userid)
    query = ("SELECT bookings.*, users.useremail, locations.*  FROM bookings, locations, users WHERE (locations.availability='0' AND locations.ownerid='#{userid}') AND (bookings.lodgerid=users.userid) AND (bookings.locationid=locations.locationid) AND (bookings.enddate > NOW())")
    result = @connection.exec(query)
  end

  def DoesUserExist(userid, useremail)
    userdata1 = getUserDataID(userid)
    userdata2 = getUserData(useremail)
    if (userdata1.num_tuples.zero? && userdata1[0]["userid"] == userdata1[1]["userid"])
      false
    else
      true
    end
  end

  def getAllRooms(startdate, enddate)
    #query = "SELECT * FROM locations WHERE locationid='SELECT locationid FROM bookings WHERE enddate < CAST('#{startdate}' AS DATE) or startdate > CAST('#{enddate}' AS DATE)'"
    #query = "SELECT locations.* FROM locations, bookings WHERE bookings.enddate < CAST('#{startdate}' AS DATE) or bookings.startdate > CAST('#{enddate}' AS DATE)"
    #query = "SELECT locations.* FROM locations, bookings WHERE bookings.enddate < '#{startdate}' or bookings.startdate > '#{enddate}'"
    query = "SELECT locations.* FROM locations, bookings WHERE 
    ('#{startdate}' NOT BETWEEN bookings.startdate AND bookings.enddate) AND ('#{enddate}' NOT BETWEEN bookings.startdate AND bookings.enddate)
    AND (locations.availability='0')
    AND NOT (('#{startdate}'=bookings.startdate)
    AND ('#{enddate}'=bookings.enddate)
    AND ('#{startdate}' < bookings.startdate AND '#{enddate}' > bookings.enddate)) "    
    result = @connection.exec(query)
    return result
  end

  def getUsersLocations(userid)
    query = "SELECT * FROM locations WHERE ownerid='#{userid}'"    
    result = @connection.exec(query)
    return result
  end

  def createLocation(userid, locName, locDesc, locPPN, locAddress)
    if isNewLocationAvailiable(locName, locDesc, locAddress)
      query = "INSERT INTO locations (ownerid, address, name, description, pricepernight, availability) VALUES('#{userid}','#{locAddress}','#{locName}','#{locDesc}','#{locPPN}', '0') RETURNING locationid"
      locationid = @connection.exec(query)[0]["locationid"]
      insert = "INSERT INTO bookings (lodgerid, locationid, startdate, enddate) VALUES ('1','#{locationid}','2000-1-1','2000-1-2')"
      @connection.exec(insert)
      true
    else
      false
    end
  end

  def isNewLocationAvailiable(locName, locDesc, locAddress)
    result = @connection.exec("SELECT * FROM Locations WHERE name='#{locName}' AND description='#{locDesc}' AND address='#{locAddress}';")
    if result.num_tuples.zero?
      true
    else
      false
    end
  end

  #Inserts the new user data into the tables
  def sign_up(useremail, password)
    if new_user_available(useremail)
      query = "INSERT INTO Users (useremail, password) VALUES('#{useremail}', '#{password}')"
      @connection.exec(query)
    end
  end

  #returns true or false if a user login is avaliable
  def new_user_available(useremail)
    result = @connection.exec("SELECT * FROM Users WHERE useremail='#{useremail}';")
    if result.num_tuples.zero?
      true
    else
      false
    end
  end

  def getUserData(useremail)
    @connection.exec("SELECT * FROM Users WHERE UserEmail='#{useremail}'")
  end

  def getUserDataID(userID)
    @connection.exec("SELECT * FROM Users WHERE UserID='#{userID}'")
  end
end
