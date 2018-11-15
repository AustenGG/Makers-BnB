# Makers BnB

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

## Technologies
* [Ruby v2.5.1](https://www.ruby-lang.org/en/)
* [Sinatra](http://www.sinatrarb.com/)
* [PostgreSQL](https://www.postgresql.org/)
* [Rspec](http://rspec.info/)
* [Capybara](https://github.com/teamcapybara/capybara)
* [Rubocop v0.56.0](https://batsov.com/rubocop/)

## Jump To
* [Functionality](#functionality)
* [Installation](#install)
* [Usage](#usage)
* [Contributors](#contributors)

## Siterep

Create a web application that allows people to rent their spaces, cos they want more money. I mean who doesn't want more money?

## Makers requirements
* Any signed-up user can list a new space.
* Users can list multiple spaces.
* Users should be able to name their space, provide a short description of the space, and a price per night.
* Users should be able to offer a range of dates where their space is available.
* Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
* Nights for which a space has already been booked should not be available for users to book that space.
* Until a user has confirmed a booking request, that space can still be booked for that night.

#### User story
```
As a user so that I can use makersbnb 
I'd like to be able to signup

As a user so that I can rent out a space to another user 
I'd like to be able to list a new space

As user so that I can rent out the apartment to multiple people 
I'd like to list multiple spaces

As a user so that I can name my spaces 
I want to be able to name the space

As a user so that my client can chose a range of dates 
I want to be to offer range of availability

As user so that I can hire a space for one night 
I want to able to request a room for one night

As a user so that I can hire out a space for a one night 
I want to be able to approve a request for one night

As a user so that I don’t over book 
I want to be remove availability for booked rooms

As a user so that I can book my spaces quickly 
I want a booking to be available until confirmed.
```

## <a name="functionality">Functionality</a>
* User can sign up
* User can login to exisiting account
* User can sign out of their account
* User can book a space
* User can list a new space to be booked, by others
* User can accept & decline booking request on their listing
* User can delete or edit their listing
* User can filter by date to see availability on rooms

## <a name="install">Installation</a>

Run the following in terminal

```
$ git clone https://github.com/AustenGG/Makers-BnB.git
$ cd Makers-BnB
$ rvm 2.5.1
$ gem install bundler
$ bundle
$ psql postgres
$ CREATE DATABASE "makersbnb";
$ \q
$ ruby db/setup.rb
```

## <a name="usage">Usage</a>

Run the above installation steps, then in the terminal:

```
$ rackup
$ open http://localhost:9292
```

You are then free to sign up for an account, and then perform any of the actions detailed in the [functionality](#functionality).

## <a name="contributors">Contributors</a>
* [Liam](https://github.com/Coombszy)
* [Austen](https://github.com/AustenGG)
* [Jordan](https://github.com/jbailey5421)
* [Omar](https://github.com/omarkhan2270)
* [Kwame](https://github.com/Kwame-M)
