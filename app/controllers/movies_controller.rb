class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    current_user.movies
    movies_by_genre
  end

  def movies_by_genre
    set_movies_by_genre
  end

  def movies_by_director
    set_movies_by_director
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
    @directors = Director.order(:name)
    @genres = Genre.order(:name)

  end

  # GET /movies/1/edit
  def edit
    set_movie
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    respond_to do |format|
      if @movie.save
        SearchMovieImageJob.perform_later(@movie)

        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        SearchMovieImageJob.perform_later(@movie)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end



  # Only allow a list of trusted parameters through.
  def movie_params
    params.require(:movie).permit(:title, :year, :resume, :duration, :director_id, :genre_id, :user_id)
  end

  def set_movies_by_genre
    if params[:genre_id].present?
      @movies = current_user.movies.where(genre_id: params[:genre_id])
    else
      @movies = current_user.movies
    end
  end

  def set_movies_by_director
    if params[:director_id].present?
      @movies = current_user.movies.where(director_id_id: params[:director_id])
    else
      @movies = current_user.movies
    end
  end
end
