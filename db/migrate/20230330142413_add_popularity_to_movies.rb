class AddPopularityToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :popularity, :integer
  end
end
