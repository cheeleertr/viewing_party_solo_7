class SimilarController < ApplicationController
  def index
    @user = User.new
    @movies = TmdbFacade.new.get_similar_movies_by_id(params[:movie_id])
  end
end