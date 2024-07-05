class AddMovieAttributesToViewingParties < ActiveRecord::Migration[7.1]
  def change
    add_column :viewing_parties, :movie_title, :string
    add_column :viewing_parties, :movie_poster_path, :string
  end
end
