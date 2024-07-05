require 'rails_helper'

RSpec.describe 'Movie Show', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com')
    @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
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
    it 'has buttons to create viewing party and return to discover page', :vcr do
      movie = TmdbFacade.new.get_movie_by_id(157336)
      visit user_movie_path(@user_1.id, movie.id)
# save_and_open_page
      expect(page).to have_button('Create Viewing Party')
      expect(page).to have_button('Discover Top Rated Movies')
    end

    it 'has movie attributes' do
      movie = TmdbFacade.new.get_movie_by_id(157336)
      visit user_movie_path(@user_1.id, movie.id)

      expect(page).to have_content("Movie: #{movie.title}")
      expect(page).to have_content("Rating: #{movie.vote_average}")
      expect(page).to have_content("Runtime: #{movie.format_runtime(movie.runtime)}")
      expect(page).to have_content("Genres: #{movie.genre}")
      expect(page).to have_content("Summary: #{movie.overview}")

      within ("#cast") do
        expect(page).to have_content("Cast:")
        expect(page).to have_css(".cast_member")
      end

      expect(page).to have_content("Total Reviews: #{movie.review_count}")

      within (".reviews") do
        expect(page).to have_content("Reviews:")
        within(first(".review")) do
          expect(page).to have_css(".author")
          expect(page).to have_css(".rating")
          expect(page).to have_css(".content")
        end
      end
    end
  end
end


