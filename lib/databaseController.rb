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

  def DoesUserExist(userid, useremail)
    userdata1 = getUserDataID(userid)
    userdata2 = getUserData(useremail)
    if (userdata1.num_tuples.zero? && userdata1[0]["userid"] == userdata1[1]["userid"])
      false
    else
      true
    end
  end

  def createLocation(userid, locName, locDesc, locPPN, locAddress)
    if isNewLocationAvailiable(locName, locDesc, locAddress)
      query = "INSERT INTO locations (ownerid, address, name, description, pricepernight, availability) VALUES('#{userid}','#{locAddress}','#{locName}','#{locDesc}','#{locPPN}', '0')"
      @connection.exec(query)
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
