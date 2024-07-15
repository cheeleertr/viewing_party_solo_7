require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create!(name: "funbucket13", email: "funbucket13@gmail.com", password: "test")

    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

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

    click_on "Log In"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Incorrect Credentials")
  end
end