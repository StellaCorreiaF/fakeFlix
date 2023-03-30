require 'rest-client'
require 'json'

class SearchMovie
  def search_movie(movie)

    api_key = Rails.application.credentials.tmdb_api_key

    url = "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&language=en-US&page=1&include_adult=false&query=#{movie}"
    response = RestClient.get url
    result = JSON.parse response

    get_image = result['results'][0]['poster_path']
    image = "https://image.tmdb.org/t/p/original#{get_image}"
  end
end
