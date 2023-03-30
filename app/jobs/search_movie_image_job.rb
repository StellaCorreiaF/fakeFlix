class SearchMovieImageJob < ApplicationJob
  queue_as :default

  def perform(movie)
    movie.image = SearchMovie.new.search_movie movie.title

    movie.save if movie.image.present?


  end
end
