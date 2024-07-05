require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user_2 = User.create!(name: 'Sam', email: 'sam@email.com')
    @user_3 = User.create!(name: 'Bob', email: 'bob@email.com')
    @user_4 = User.create!(name: 'Jimmy', email: 'jimmy@email.com')

    @movie_1 = TmdbFacade.new.get_movie_by_id(155)
    @movie_2 = TmdbFacade.new.get_movie_by_id(157336)
    @movie_3 = TmdbFacade.new.get_movie_by_id(122)

    @party_1 = ViewingParty.create!(
      duration: 200, 
      start_time: Time.now + 1, 
      date: Date.today + 1, 
      movie_id: @movie_1.id, 
      movie_title: @movie_1.title, 
      movie_poster_path: @movie_1.poster_path)

    @party_2 = ViewingParty.create!(
      duration: 200, 
      start_time: Time.now + 1, 
      date: Date.today + 2, 
      movie_id: @movie_2.id, 
      movie_title: @movie_2.title, 
      movie_poster_path: @movie_2.poster_path)

    @party_3 = ViewingParty.create!(
      duration: 200, 
      start_time: Time.now + 1, 
      date: Date.today + 3, 
      movie_id: @movie_3.id, 
      movie_title: @movie_3.title, 
      movie_poster_path: @movie_3.poster_path)

    @user_1.user_parties.create!(user_id: @user_1.id, viewing_party_id: @party_1.id, host: true)
    @user_2.user_parties.create!(user_id: @user_2.id, viewing_party_id: @party_2.id, host: true)
    @user_2.user_parties.create!(user_id: @user_2.id, viewing_party_id: @party_1.id, host: true)
    @user_3.user_parties.create!(user_id: @user_3.id, viewing_party_id: @party_1.id, host: true)
    @user_3.user_parties.create!(user_id: @user_3.id, viewing_party_id: @party_3.id, host: true)
    @user_1.user_parties.create!(user_id: @user_1.id, viewing_party_id: @party_2.id, host: false)
    @user_1.user_parties.create!(user_id: @user_1.id, viewing_party_id: @party_3.id, host: false)
# binding.pry
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
  it 'can see invited viewing parties', :vcr do

    expect(page).to have_content('Invited to Viewing Parties')
# save_and_open_page
    within(".invited_parties") do
      within(first(".party")) do
        expect(page).to have_css(".title")
        within(".title") do
          expect(page).to have_link("")
        end
        expect(page).to have_css(".image")
        expect(page).to have_css(".time")
        expect(page).to have_css(".host")
        expect(page).to have_css(".attendees")
        within(first(".attendees")) do
          expect(page).to have_content("Tommy")
          expect(page).to have_content("Sam")
          expect(page).to have_css(".name")
        end
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
        expect(page).to have_css(".attendees")
        within(first(".attendees")) do
          expect(page).to have_content("Tommy")
          expect(page).to have_content("Sam")
          expect(page).to have_content("Bob")
          expect(page).to have_css(".name")
        end
      end
    end
  end
end

