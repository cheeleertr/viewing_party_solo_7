require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create!(name: "funbucket13", email: "funbucket13@gmail.com", password: "test")

    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    within(".field") do
      click_on "Log In"
    end

    expect(current_path).to eq(user_path(user.id))

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in without valid credentials" do
    user = User.create!(name: "funbucket13", email: "funbucket13@gmail.com", password: "test")

    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq(login_path)

    fill_in :email, with: 'funbucket13@gmail.com'
    fill_in :password, with: 'invalid_password'

    within(".field") do
      click_on "Log In"
    end
    expect(current_path).to eq(login_path)

    expect(page).to have_content("Incorrect Credentials")
  end

  it "can store location in cookie so when I logout I still see my location in the location field" do
    user = User.create!(name: "funbucket13", email: "funbucket13@gmail.com", password: "test")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :location, with: "Denver, CO"

    within(".field") do
      click_on "Log In"
    end

    expect(current_path).to eq(user_path(user.id))

    click_on "Log Out"

    visit login_path

    expect(page).to have_field('location', with: 'Denver, CO')
  end

  it "cannot see buttons to login or register while logged in but can see a logout button to log out" do
    user = User.create!(name: "funbucket13", email: "funbucket13@gmail.com", password: "test")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :location, with: "Denver, CO"

    within(".field") do
      click_on "Log In"
    end

    expect(current_path).to eq(user_path(user.id))
    expect(page).to_not have_link("Log In")
    expect(page).to_not have_link("Register as a User")
    
    click_on "Log Out"
    
    expect(current_path).to eq(root_path)
    expect(page).to have_link("Log In")
    expect(page).to have_link("Register as a User")
  end

  it "cannot see existing users until I log in" do
    user = User.create!(name: "funbucket13", email: "funbucket13@gmail.com", password: "test")

    visit login_path

    expect(page).to_not have_content("Existing Users")
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :location, with: "Denver, CO"
    
    within(".field") do
      click_on "Log In"
    end
    
    expect(page).to_not have_content("Existing Users")
    expect(current_path).to eq(user_path(user.id))
    expect(page).to_not have_link("Log In")
    expect(page).to_not have_link("Register as a User")
    
    click_on "Log Out"
    
    expect(current_path).to eq(root_path)
    expect(page).to have_link("Log In")
    expect(page).to have_link("Register as a User")
  end

  it "cannot see user dashboard unless Im logged in" do
    user = User.create!(name: "funbucket13", email: "funbucket13@gmail.com", password: "test")

    visit root_path

    visit user_path(user.id)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You Must Be Logged In")
  end

  it "cannot create a viewing party unless Im logged in", :vcr do
    user = User.create!(name: "funbucket13", email: "funbucket13@gmail.com", password: "test")
    movie = TmdbFacade.new.get_movie_by_id(157336)
    
    visit new_user_movie_viewing_party_path(user, movie.id)

    fill_in "date", with: Date.today + 1
    fill_in "start_time", with: Time.now + 1.hour
    fill_in "duration", with: 240

    click_button "Create Viewing Party"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You Must Be Logged In")
  end

  # it "remembers user even if user navigates to a different website then returns" do
  #   user = User.create!(name: "funbucket13", email: "funbucket13@gmail.com", password: "test")

  #   visit login_path

  #   fill_in :email, with: user.email
  #   fill_in :password, with: user.password
  #   fill_in :location, with: "Denver, CO"

  #   within(".field") do
  #     click_on "Log In"
  #   end

  #   expect(current_path).to eq(user_path(user.id))

  #   visit "www.google.com"

  #   visit user_path(user.id)

  #   expect(page).to have_content("Welcome, #{user.name}")
  #   expect(page).to have_link("Log Out")
  # end
end