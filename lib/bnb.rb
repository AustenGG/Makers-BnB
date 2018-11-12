class Bnb

  def self.sign_up(username:, password:)
    connection = PG.connect(dbname: 'MakersBnB')
    query = "INSERT INTO user_details (username, password) VALUES('#{username}', '#{password}') RETURNING username, password;"
    connection.exec(query)
  end

  def self.sign_in(si_username:, si_password:)
    connection = PG.connect(dbname: 'MakersBnB')
    query = "SELECT username FROM user_details WHERE username = '#{si_username}' AND password = '#{si_password}';"
    result = connection.exec(query)
    if result.map { |user_details| user_details['username']} == [si_username]
      return true
    else
      return false
    end
  end
end
