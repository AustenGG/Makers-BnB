class Bnb

  def self.sign_up(username:, password:)
    connection = PG.connect(dbname: 'makersbnb')
    query = "INSERT INTO logins (username, password) VALUES('#{username}', '#{password}') RETURNING username, password;"
    connection.exec(query)
  end

  def self.sign_in(si_username:, si_password:)
    connection = PG.connect(dbname: 'makersbnb')
    query = "SELECT username FROM logins WHERE username = '#{si_username}' AND password = '#{si_password}';"
    result = connection.exec(query)
    if result.map { |logins| logins['username']} == [si_username]
      return true
    else
      return false
    end
  end
end
