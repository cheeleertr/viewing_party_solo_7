class TmdbService
  def self.conn
    Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params[:api_key] = Rails.application.credentials.tmdb[:key]
    end
  end

  def self.get_movies_by_title(title)
    response = conn.get("/3/search/movie?query=#{title}&limit=20")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_top_movies
    response = conn.get("/3/movie/top_rated?limit=20")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_movie_by_id(movie_id)
    response = conn.get("/3/movie/#{movie_id}?append_to_response=reviews,credits,watch/providers")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_similar_movies_by_id(movie_id)
    response = conn.get("/3/movie/#{movie_id}/similar")
    JSON.parse(response.body, symbolize_names: true)
  end
end