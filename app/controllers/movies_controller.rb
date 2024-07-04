class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    if params[:search]
      @movies = TmdbFacade.new.get_movies_by_title(params[:search])
    else
      @movies = TmdbFacade.new.get_top_movies
    end
  end

  def show
    @user = User.find(params[:user_id])
    #update later
    #search api by movie id?
    @movie = TmdbFacade.new.get_movie_by_id(params[:id])
  end
end
