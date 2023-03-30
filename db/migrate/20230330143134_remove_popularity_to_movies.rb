class RemovePopularityToMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :popularity
  end
end
