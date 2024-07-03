require 'rails_helper'

RSpec.describe 'Discover Index', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com')
  end
  # When I visit the discover movies page ('/users/:id/discover'),
  # and click on either the Discover Top Rated Movies button or fill out the movie title search and click the Search button,
  # I should be taken to the movies results page (`users/:user_id/movies`) where I see: 
  # - Title (As a Link to the Movie Details page (see story #3))
  # - Vote Average of the movie
  # I should also see a button to return to the Discover Page.
  describe 'search movies' do
    it 'can see results of discover top rated movies', :vcr do
      visit "/users/#{@user_1.id}/discover"

      click_button('Discover Top Rated Movies')

      within(first(".movie")) do
        expect(page).to have_css(".title")
        expect(page).to have_css(".vote_average")
      end

      # is there a way to save record into variable to use for test assertion
      # so if the response updates the variable will too

      # expect(page).to have_content("Title: ")
      # expect(page).to have_link("movie[:original_title]")
      # expect(page).to have_content("Vote Average: ")
      # expect(page).to have_link("movie[:vote_average]")
    end

    it 'can see results of search by movie title', :vcr do
      visit "/users/#{@user_1.id}/discover"

      fill_in "search", with: "Interstellar"
      click_button('Search')

      within(first(".movie")) do
        expect(page).to have_css(".title")
        expect(page).to have_css(".vote_average")
      end
      # expect(page).to have_content("Title: Interstellar")
      # expect(page).to have_link("movie[:original_title]")
      # expect(page).to have_content("Vote Average: ")
      # expect(page).to have_link("movie[:vote_average]")
    end
  end
end
