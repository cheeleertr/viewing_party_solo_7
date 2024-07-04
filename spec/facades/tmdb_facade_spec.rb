require "rails_helper"

RSpec.describe TmdbFacade do
  describe "#get_movies_by_title", :vcr do
    it "should return Movie objects when givin title" do
      facade = TmdbFacade.new
      response = facade.get_movies_by_title("interstellar")

      expect(response).to be_an Array
      expect(response).to be_all Movie
    end
  end

  describe "#get_top_movies", :vcr do
    it "should return top rated Movie objects" do
      facade = TmdbFacade.new
      response = facade.get_top_movies

      expect(response).to be_an Array
      expect(response).to be_all Movie
    end
  end

  describe "#get_movie_by_id", :vcr do
    it "should return Movie object when givin id" do
      facade = TmdbFacade.new
      response = facade.get_movie_by_id(157336)

      expect(response).to be_a Movie
      expect(response.title).to eq("Interstellar")
    end
  end
end