require 'rails_helper'
require 'faker'

RSpec.describe "/genres", type: :request do
  before { with_signed_in_user }

  let(:valid_attributes){
    {
      name: "Drama"
    }
  }



  let(:invalid_attributes) { {
    name: nil
  }}
  describe "GET /index" do
    it "renders a successful response" do
      Genre.create! valid_attributes
      get genres_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      genre = Genre.create! valid_attributes
      get genre_url(genre)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_genre_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      genre = Genre.create! valid_attributes
      get edit_genre_url(genre)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Genre" do
        expect {
          post genres_url, params: { genre: valid_attributes }
        }.to change(Genre, :count).by(1)
      end

      it "redirects to the created genre" do
        post genres_url, params: { genre: valid_attributes }
        expect(response).to redirect_to(genre_url(Genre.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Genre" do
        expect {
          post genres_url, params: { genre: invalid_attributes }
        }.to_not change(Genre, :count)


      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post genres_url, params: { genre: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {name: "Comédia Romântica" }
      }

      it "updates the requested genre" do
        genre = Genre.create! valid_attributes
        patch genre_url(genre), params: { genre: new_attributes }
        genre.reload
        expect(genre.name).to eq "Comédia Romântica"
      end

      it "redirects to the genre" do
        genre = Genre.create! valid_attributes
        patch genre_url(genre), params: { genre: new_attributes }
        genre.reload
        expect(response).to redirect_to(genre_url(genre))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        genre = Genre.create! valid_attributes
        patch genre_url(genre), params: { genre: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested genre" do
      genre = Genre.create! valid_attributes
      expect {
        delete genre_url(genre)
      }.to change(Genre, :count).by(-1)
    end

    it "redirects to the genres list" do
      genre = Genre.create! valid_attributes
      delete genre_url(genre)
      expect(response).to redirect_to(genres_url)
    end
  end
end
