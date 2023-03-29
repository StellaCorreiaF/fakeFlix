require 'rails_helper'

RSpec.describe "/movies", type: :request do

  before { with_signed_in_user }

  let(:genre) { Genre.create(name: "Drama") }

  let(:director) { Director.create(name: "James Cameron") }

  let(:valid_attributes) {
    { title: "Titanic",
      resume: " xxxxxxxxxxxxx",
      genre_id: genre.id,
      director_id: director.id,
      user_id: signed_in_user.id
    }
  }

  let(:invalid_attributes) {
    { user_id: nil,
      genre_id: nil,
      director_id: nil}
  }

  describe "GET /show" do
    it "renders a successful response" do
      movie = Movie.create! valid_attributes
      get movie_url(movie)
      expect(response).to be_successful
    end
  end

  describe "GET /index" do
    it "returns http success" do
      Movie.create! valid_attributes
      get movies_url
      expect(response).to have_http_status(:success)

    end
  end
  describe "GET /new" do
    it "renders a successful response" do
      get new_movie_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      movie = Movie.create! valid_attributes
      get edit_movie_url(movie)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Movie" do
        expect {
          post movies_url, params: { movie: valid_attributes }
        }.to change(Movie, :count).by(1)
      end

      it "redirects to the created movie" do
        post movies_url, params: { movie: valid_attributes }
        expect(response).to redirect_to(movie_url(Movie.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Movie" do
        expect {
          post movies_url, params: { movie: invalid_attributes }
        }.to change(Movie, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post movies_url, params: { movie: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { resume: "Titanic" }
      }
      it "updates the requested movie" do
        movie = Movie.create! valid_attributes
        patch movie_url(movie), params: { movie: new_attributes }
        movie.reload
        expect(movie.resume).to eq "Titanic"
      end

      it "redirects to the movie" do
        movie = Movie.create! valid_attributes
        patch movie_url(movie), params: { movie: new_attributes }
        movie.reload
        expect(response).to redirect_to(movie_url(movie))
      end
    end

    context "with invalid parameters" do

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        movie = Movie.create! valid_attributes
        patch movie_url(movie), params: { movie: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested movie" do
      movie = Movie.create! valid_attributes
      expect {
        delete movie_url(movie)
      }.to change(Movie, :count).by(-1)
    end

    it "redirects to the movies list" do
      movie = Movie.create! valid_attributes
      delete movie_url(movie)
      expect(response).to redirect_to(movies_url)
    end
  end
end
