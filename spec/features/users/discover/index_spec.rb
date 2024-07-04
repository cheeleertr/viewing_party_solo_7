require 'rails_helper'

RSpec.describe 'Discover Index', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com')
  end
# As a user,
# When I visit the '/users/:id/discover' path (where :id is the id of a valid user),
# I should see
# - a Button to Discover Top Rated Movies
# - a text field to enter keyword(s) to search by movie title
# - a Button to Search by Movie Title
  describe 'has buttons to search movies', :vcr do
    it 'has button to discover top rate movies' do
      visit "/users/#{@user_1.id}/discover"

      expect(page).to have_button('Discover Top Rated Movies')
      click_button('Discover Top Rated Movies')

      expect(current_path).to eq(user_movies_path(@user_1))
    end

    it 'can search for movie by movie title', :vcr do
      visit "/users/#{@user_1.id}/discover"

      fill_in "search", with: "Interstellar"
      click_button('Search')

      expect(current_path).to eq(user_movies_path(@user_1))
    end
  end
end


