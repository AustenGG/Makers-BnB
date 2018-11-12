require 'data_mapper'
 require 'dm-postgres-adapter'

 class Space
   include DataMapper::Resource

   property :id,           Serial
   property :name,         String
   property :description,  Text
   property :price,        Integer
   property :available_from,     Date
   property :available_to,    Date

 end

 DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
 DataMapper.finalize
 DataMapper.auto_upgrade!
