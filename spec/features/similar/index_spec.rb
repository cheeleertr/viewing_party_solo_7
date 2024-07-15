require 'rails_helper'

RSpec.describe 'Similar Movie index', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com', password: "same")
    @movie = TmdbFacade.new.get_movie_by_id(157336)
  end
  # As a user, 
  # When I visit a Movie Details page (`/users/:user_id/movies/:movie_id`),
  # I see a link for "Get Similar Movies"
  # When I click that link
  # I am taken to the Similar Movies page (`/users/:user_id/movies/:movie_id/similar`)
  # Where I see a list of movies that are similar to the one provided by :movie_id, 
  # which includes the similar movies': 
  # - Title
  # - Overview
  # - Release Date
  # - Poster image
  # - Vote Average
  it 'From movies show, I can click on get similar movies to get to similar index page with similar movies', :vcr do
    visit user_movie_path(@user_1, @movie.id)

    click_button "Get Similar Movies"

    expect(page).to have_current_path(user_movie_similar_index_path(@user_1, @movie.id))
    expect(page).to have_content("Similar Movies")
    within (".similar_movies") do
      within(first(".movie")) do
        expect(page).to have_css(".image")
        expect(page).to have_css(".title")
        expect(page).to have_css(".vote_average")
        expect(page).to have_css(".overview")
        expect(page).to have_css(".release_date")
      end
    end
  end
end