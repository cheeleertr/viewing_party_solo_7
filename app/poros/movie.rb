class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime, 
              :genre, 
              :overview, 
              :cast, 
              :review_count, 
              :reviewers,
              :buy_providers,
              :rent_providers,
              :release_date,
              :poster_path

  def initialize(movie_data)
    @id = movie_data[:id]
    @title = movie_data[:original_title]
    @vote_average = movie_data[:vote_average]
    @runtime = movie_data[:runtime]
    @genre = format_genre(movie_data[:genres])
    @overview = movie_data[:overview]
    @cast = format_cast_to_name_and_character(movie_data.dig(:credits, :cast))
    @review_count = movie_data.dig(:reviews, :total_results)
    @reviewers = movie_data.dig(:reviews, :results)
    #maybe create reviewer objects later
    @buy_providers = format_providers(movie_data.dig(:"watch/providers", :results, :US, :buy))
    @rent_providers = format_providers(movie_data.dig(:"watch/providers", :results, :US, :rent))
    @poster_path = movie_data[:poster_path]
    @release_date = movie_data[:release_date]
  end

  def format_runtime(total_minutes)
    if total_minutes.nil?
      nil
    else
      hours = total_minutes / 60
      minutes = (total_minutes) % 60
      "#{hours}h #{minutes}min"
    end
  end

  def format_genre(genre_data)
    if genre_data.nil?
      nil
    else
      genre_data.map {|genre| genre[:name]}.join(", ")
    end
  end

  def format_cast_to_name_and_character(cast_data)
    if cast_data.nil?
      nil
    else
      cast_data.first(10).map {|cast| {name: cast[:name], character: cast[:character]}}
    end
  end

  def format_providers(watch)
    if watch.nil?
      nil
    else
    watch.map {|provider| {logo_path: provider[:logo_path], provider: provider[:provider_name]}}
    end
  end
  
end