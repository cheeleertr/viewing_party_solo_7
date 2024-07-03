class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.headers["X-API-Key"] = Rails.application.credentials.tmdb[:key]
    end

    if params[:search]
      response = conn.get("/3/search/movie?query=#{params[:search]}")
    else
      response = conn.get("/3/discover/movie?limit=20")
    end
# binding.pry
#body is currently '', says invalid api key
    json = JSON.parse(response.body, symbolize_names: true)
    @movies = json[:results]
  end
end
