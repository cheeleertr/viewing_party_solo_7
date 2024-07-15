require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do
    visit root_path

    click_on "Register as a User"

    expect(current_path).to eq(new_user_path)

    email = "funbucket13@gmail.com"
    username = "funbucket13"
    password = "test"

    fill_in :email, with: email
    fill_in :name, with: username
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on "Create New User"

    expect(page).to have_content("Welcome, #{username}!")
  end

  it "creates returns errors when not filling required info for new user" do
    visit root_path

    click_on "Register as a User"

    expect(current_path).to eq(new_user_path)

    fill_in :email, with: ''
    fill_in :name, with: ''
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''

    click_on "Create New User"

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Password can't be blank")
    # expect(page).to have_content("Password digest can't be blank")
  end
end