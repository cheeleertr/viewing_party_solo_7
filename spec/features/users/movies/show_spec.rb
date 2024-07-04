require 'rails_helper'

RSpec.describe 'Movie Show', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com')
  end
  # As a user, 
  # When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`) where :id is a valid user id,
  # I should see
  # - a button to Create a Viewing Party
  # - a button to return to the Discover Page
  
  # I should also see the following information about the movie:
  
  # - Movie Title
  # - Vote Average of the movie
  # - Runtime in hours & minutes
  # - Genre(s) associated to movie
  # - Summary description
  # - List the first 10 cast members (characters & actress/actors)
  # - Count of total reviews
  # - Each review's author and information
  
  describe 'movie details' do
    xit 'has buttons to create viewing party and return to discover page' do
      @movie 
      visit user_movie_path(@user_1.id, @movie.id)

      expect(page).to have_button('Create Viewing Party')
      expect(page).to have_button('Discover Top Rated Movies')
      

    end

    xit 'has movie attributes' do
      visit "/users/#{@user_1.id}/discover"

      fill_in "search", with: "Interstellar"
      click_button('Search')

      expect(page).to have_content('Movie: ')
      expect(page).to have_content('Vote Average: ')
      expect(page).to have_content('Runtime: hrs, min')
      expect(page).to have_content('Genres: ')
      expect(page).to have_content('Summary: ')
      expect(page).to have_content('Cast: ')
      expect(page).to have_content('Total Reviews: ')
      expect(page).to have_content('Reviewer Info: ')
    end
  end
end


