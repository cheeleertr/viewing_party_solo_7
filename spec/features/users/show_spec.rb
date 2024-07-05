require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user_2 = User.create!(name: 'Sam', email: 'sam@email.com')
    @user_3 = User.create!(name: 'Bob', email: 'bob@email.com')
    @user_4 = User.create!(name: 'Jimmy', email: 'jimmy@email.com')

    @movie_1 = TmdbFacade.new.get_movie_by_id(155)
    @movie_2 = TmdbFacade.new.get_movie_by_id(157336)

    @party_1 = ViewingParty.create!(duration: 200, start_time: "05:00 PM", date: Date.today + 2)
    @party_2 = ViewingParty.create!(duration: 200, start_time: "02:00 PM", date: Date.today + 1)
    @party_3 = ViewingParty.create!(duration: 200, start_time: "02:00 PM", date: Date.today + 1)
    visit user_path(@user_1)
  end
# As a user,
# When I visit a user dashboard ('/user/:user_id'),
# I should see the viewing parties that the user has been invited to with the following details:
# - Movie Image
# - Movie Title, which links to the movie show page
# - Date and Time of Event
# - who is hosting the event
# - list of users invited, with my name in bold
# I should also see the viewing parties that the user has created (hosting) with the following details:
# - Movie Image
# - Movie Title, which links to the movie show page
# - Date and Time of Event
# - That I am the host of the party
# - List of friends invited to the viewing party
  xit 'can see invited viewing parties', :vcr do

    expect(page).to have_content('Invited to Viewing Parties')

    within(".invited_parties") do
      within(first(".party")) do
        expect(page).to have_css(".title")
        within(".title") do
          expect(page).to have_link("")
        end
        expect(page).to have_css(".image")
        expect(page).to have_css(".time")
        expect(page).to have_css(".host")
        expect(page).to have_css(".invited")
      end
    end

    within(".hosted_parties") do
      within(first(".party")) do
        expect(page).to have_css(".title")
        within(".title") do
          expect(page).to have_link("")
        end
        expect(page).to have_css(".image")
        expect(page).to have_css(".time")
        expect(page).to have_css(".host")
        expect(page).to have_css(".invited")
      end
    end
  end
end

