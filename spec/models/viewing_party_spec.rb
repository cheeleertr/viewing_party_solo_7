require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe "validations" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :start_time }
  end

  before(:each) do
      @user_1 = User.create!(name: 'Sam', email: 'sam@email.com', password: "same")
      @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "same")
      @party = ViewingParty.create!(date: Date.today + 1, start_time: Time.now + 1, duration: 175)
      UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
      UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end
  
  describe 'relationships' do
      it { should have_many :user_parties }
      it { should have_many(:users).through(:user_parties) }
  end

  describe "instance methods" do
    it "returns user that is hosting the party" do
      expect(@party.find_host).to eq (@user_1)
    end
  end
end