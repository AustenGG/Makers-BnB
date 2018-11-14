require 'pg'

class Bnb
  def initialize
    @connection = PG.connect(dbname: 'makersbnb')
  end

  def self.sign_up(username:, password:)
    if new_user_available(username)
      query = "INSERT INTO logins (username, password) VALUES('#{username}', '#{password}') RETURNING username, password;"
      @connection.exec(query)
    end
  end

  #returns true or false if the login is correct
  def self.sign_in(si_username:, si_password:)
    query = "SELECT username FROM logins WHERE username = '#{si_username}' AND password = '#{si_password}';"
    result = @connection.exec(query)
    if result.map { |logins| logins['username']} == [si_username]
      return true
    else
      return false
    end
  end

  #returns true or false if a user login is avaliable
  def self.new_user_available(username:)
    result = @connection.exec("SELECT * FROM logins WHERE username='#{username}';")
    if result.num_tuples.zero?
      true
    else
      false
    end
  end
end