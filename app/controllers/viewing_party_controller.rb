class ViewingPartyController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @other_users = User.all_except(params[:user_id])
    @movie = TmdbFacade.new.get_movie_by_id(params[:movie_id])
  end

  def show
    @party = ViewingParty.find(params[:id])
    @movie = TmdbFacade.new.get_movie_by_id(params[:movie_id])
  end

  def create
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.save
      UserParty.create!(user_id: params[:user_id], viewing_party_id: viewing_party.id, host: true)
      params[:user_ids].each do |id|
          UserParty.create!(user_id: id, viewing_party_id: viewing_party.id, host: false)
      end
        flash[:success] = 'Successfully Created New Viewing Party'
        redirect_to user_path(params[:user_id])
    else
        flash[:error] = "#{error_message(viewing_party.errors)}"
        redirect_to new_user_movie_viewing_party_path(params[:user_id], params[:movie_id])
    end   
  end
  
  private
  def viewing_party_params
    params.permit(:duration, :date, :start_time)
  end
end