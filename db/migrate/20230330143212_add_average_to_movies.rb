class AddAverageToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :average, :float
  end
end
