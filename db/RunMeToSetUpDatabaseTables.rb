require 'pg'

@db = PG.connect(dbname: 'makersbnb')

#Creates table logins
@db.exec("CREATE TABLE logins(username VARCHAR(60), password VARCHAR(60));")