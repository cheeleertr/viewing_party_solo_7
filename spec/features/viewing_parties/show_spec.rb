require 'rails_helper'

RSpec.describe 'Viewing Party show', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com')
    @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @movie = TmdbFacade.new.get_movie_by_id(157336)
    @viewing_party = ViewingParty.create!(duration: 200, start_time: Time.now + 1, date: Date.today + 1)
    visit user_movie_viewing_party_path(@user_1, @movie.id, @viewing_party.id)
  end
  # As a user, 
  # When I visit a Viewing Party's show page (`/users/:user_id/movies/:movie_id/viewing_party/:id`), 
  # I should see 
  # - logos of video providers for where to buy the movie (e.g. Apple TV, Vudu, etc.)
  # - logos of video providers for where to rent the movie (e.g. Amazon Video, DIRECTV, etc.)
  # And I should see a data attribution for the JustWatch platform that reads: 
  # "Buy/Rent data provided by JustWatch",
  # as per TMDB's instructions.
  it 'can see data attribution for JustWatch and logos of video providers where to buy and rent movie', :vcr do

    expect(page).to have_content('Buy/Rent data provided by JustWatch')
    expect(page).to have_content("Where to Buy")
    expect(page).to have_content("Where to Rent")
    
    within(first(".seller")) do
      expect(page).to have_css(".image")
    end

    within(first(".renter")) do
      expect(page).to have_css(".image")
    end
  end
end