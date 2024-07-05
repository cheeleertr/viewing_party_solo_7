require 'rails_helper'

describe TmdbService do
  context "class methods" do
    context "#get_movies_by_title" do
      it "returns movie data", :vcr do
        search = TmdbService.get_movies_by_title("Interstellar")

        expect(search).to be_a Hash
        expect(search[:results]).to be_an Array
        movie_data = search[:results].first

        expect(movie_data).to have_key :id
        expect(movie_data[:id]).to be_a(Integer)

        expect(movie_data).to have_key :original_title
        expect(movie_data[:original_title]).to be_a(String)

        expect(movie_data).to have_key :vote_average
        expect(movie_data[:vote_average]).to be_a(Float)
      end
    end

    context "#get_top_movies" do
      it "returns movie data", :vcr do
        search = TmdbService.get_top_movies

        expect(search).to be_a Hash
        expect(search[:results]).to be_an Array
        movie_data = search[:results].first

        expect(movie_data).to have_key :id
        expect(movie_data[:id]).to be_a(Integer)

        expect(movie_data).to have_key :original_title
        expect(movie_data[:original_title]).to be_a(String)

        expect(movie_data).to have_key :vote_average
        expect(movie_data[:vote_average]).to be_a(Float)
      end
    end

    context "#get_movies_by_id" do
      it "returns movie data", :vcr do
        movie_data = TmdbService.get_movie_by_id(157336)

        expect(movie_data).to be_a Hash

        expect(movie_data).to have_key :id
        expect(movie_data[:id]).to be_a(Integer)

        expect(movie_data).to have_key :original_title
        expect(movie_data[:original_title]).to be_a(String)

        expect(movie_data).to have_key :vote_average
        expect(movie_data[:vote_average]).to be_a(Float)

        expect(movie_data).to have_key :runtime
        expect(movie_data[:runtime]).to be_a(Integer)

        expect(movie_data).to have_key :genres
        expect(movie_data[:genres]).to be_a(Array)

        expect(movie_data).to have_key :overview
        expect(movie_data[:overview]).to be_a(String)

        expect(movie_data).to have_key :credits
        expect(movie_data[:credits]).to be_a(Hash)

        expect(movie_data).to have_key :reviews
        expect(movie_data[:reviews]).to be_a(Hash)
      end
    end
  end
end