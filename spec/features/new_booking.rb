require 'booking'

feature 'new booking' do
  scenario 'making a booking' do
    setup_test_database
    visit('/booking')
    fill_in('Bookings Date', with: '11/09/19')
    fill_in('Bookings Location', with: 'Birmingham')
    click_button('Sign up Submit')

    expect(Booking.date_list).to include '11/09/19'
    expect(Booking.location_list).to include 'Birmingham'

    expect(page).to have_content('This is the booking page')

  end
end
