#-------------- READ ME --------------
#First go through PRE-SETUP if you have created any database for this called makersbnb
#Next go through the SETUP file and that it! the database config and the server should work fine




#--------------PRE-SETUP--------------
#If you already have a database from before you will need to delete it
#Do this by doing the following commands in terminal, skip to SETUP if you never create the database in the first place:

#psql postgres
#DROP DATABASE "makersbnb";
#\q

#-------------- COMPLETE PRE-SETUP --------------




#-------------- SETUP --------------
#next you need to create the new database with the correct new tables and their links.
#Do this by first entering these commands:

#psql postgres
#CREATE DATABASE "makersbnb";
#\q

#Then you need to run this ruby file to actually create the tables, Do this in the terminal like this

#ruby db/setup.rb

#-------------- COMPLETE SETUP --------------

#-------------- IGNORE THIS --------------
require 'pg'
@db = PG.connect(dbname: 'makersbnb')

#Creates table users
@db.exec("CREATE TABLE USERS(UserID SERIAL PRIMARY KEY, useremail VARCHAR(60), password VARCHAR(60));")
#Creates table locations
@db.exec("CREATE TABLE LOCATIONS(LocationID SERIAL PRIMARY KEY, OwnerID int, Address VARCHAR(255), Name VARCHAR(255), Description VARCHAR(511), PricePerNight MONEY, Availability int, FOREIGN KEY (OwnerID) REFERENCES Users(UserID));")
#Creates table bookings
@db.exec("CREATE TABLE BOOKINGS(BookingID SERIAL PRIMARY KEY, LodgerID int, LocationID int, StartDate DATE, EndDate DATE, FOREIGN KEY (LodgerID) REFERENCES USERS(UserID), FOREIGN KEY (LocationID) REFERENCES LOCATIONS(LocationID));")

query = "INSERT INTO Users (useremail, password) VALUES('TESTUSERNEVERUSE', '5AF76621A5A239')"
@db.exec(query)