class TmdbFacade
  def initialize
  end

  def get_movies_by_title(title)
    json = TmdbService.get_movies_by_title(title)
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def get_top_movies
    json = TmdbService.get_top_movies
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def get_movie_by_id(id)
    json = TmdbService.get_movie_by_id(id)
    Movie.new(json)
  end

  def get_similar_movies_by_id(id)
    json = TmdbService.get_similar_movies_by_id(id)
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end