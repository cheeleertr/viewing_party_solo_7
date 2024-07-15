require 'rails_helper'

RSpec.describe 'Viewing Party new', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com', password: "same")
    @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "same")
    @movie = TmdbFacade.new.get_movie_by_id(157336)
    
    visit new_user_movie_viewing_party_path(@user_1, @movie.id)
  end
# When I visit the new viewing party page ('/users/:user_id/movies/:movie_id/viewing_party/new', where :user_id is a valid user's id and :movie_id is a valid Movie id from the API),
# I should see the name of the movie title rendered above a form with the following fields:
# - Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie
# - When: field to select date
# - Start Time: field to select time
# - Guests: three (optional) text fields for guest email addresses 
# - Button to create a party
  it 'can see name of movie and fill form to create new Viewing Party', :vcr do
    fill_in "date", with: Date.today + 1
    fill_in "start_time", with: Time.now + 1.hour
    fill_in "duration", with: 240
    within(".user_#{@user_2.id}") do
      check('user_ids[]')
    end

    click_button "Create Viewing Party"

    expect(current_path).to eq(user_path(@user_1))

    expect(page).to have_content('Successfully Created New Viewing Party')
    expect(page).to have_content("Party Time: #{Date.today + 1} at #{Time.now + 1.hour}")
    expect(page).to have_content("Host: Sam")
    within ".attendees" do
      expect(page).to have_content('Sam')
      expect(page).to have_content('Tommy')
    end
  end

  it 'errors when fill in form with a past date and time', :vcr do
    fill_in "date", with: Date.today - 1
    fill_in "start_time", with: Time.now - 1.hour
    fill_in "duration", with: 240

    click_button "Create Viewing Party"

    expect(current_path).to eq(new_user_movie_viewing_party_path(@user_1, @movie.id))
    expect(page).to have_content("Date can't be in the past")
    expect(page).to have_content("Start time can't be in the past")
  end

  it 'errors when submit with blank date and time', :vcr do

    click_button "Create Viewing Party"

    expect(current_path).to eq(new_user_movie_viewing_party_path(@user_1, @movie.id))
    expect(page).to have_content("Date can't be blank")
    expect(page).to have_content("Start time can't be blank")
  end
end