require 'rails_helper'

RSpec.describe Movie do
  # before(:each). vcr do
  #   json = TmdbService.get_movie_by_id(157336)

  #   movie = Movie.new(json)
  # end

  it "can create Movie from hash and have attributes", :vcr do
    json = TmdbService.get_movie_by_id(157336)
    movie = Movie.new(json)

    expect(movie).to be_a Movie
    expect(movie.title).to eq("Interstellar")
    expect(movie.id).to eq(157336)
    expect(movie.vote_average).to eq(8.436)
    expect(movie.runtime).to eq("2h 49min")
    expect(movie.genre).to eq(["Adventure", "Drama", "Science Fiction"])
    expect(movie.overview).to eq("The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.")
    expect(movie.cast).to eq(
      [{:character=>"Cooper", :name=>"Matthew McConaughey"},
      {:character=>"Brand", :name=>"Anne Hathaway"},
      {:character=>"Professor Brand", :name=>"Michael Caine"},
      {:character=>"Murph", :name=>"Jessica Chastain"},
      {:character=>"Tom", :name=>"Casey Affleck"},
      {:character=>"Doyle", :name=>"Wes Bentley"},
      {:character=>"Getty", :name=>"Topher Grace"},
      {:character=>"Murph (10 Yrs.)", :name=>"Mackenzie Foy"},
      {:character=>"Murph (older)", :name=>"Ellen Burstyn"},
      {:character=>"Donald", :name=>"John Lithgow"}]
    )
    expect(movie.review_count).to eq(16)
    expect(movie.reviewers).to be_a Array
    expect(movie.reviewers).to be_all Hash
  end
  # it "#format_runtime" do

  # expect()
  # end
end