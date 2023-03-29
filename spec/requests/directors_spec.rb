require 'rails_helper'

RSpec.describe "/directors", type: :request do
  before { with_signed_in_user }
  let(:valid_attributes) {
    {
      name: "Guel Arraes"
    }
  }
  let(:invalid_attributes) {
  }

  describe "GET /index" do
    it "returns http success" do
      director = Director.create! valid_attributes
      get directors_url
      expect(response).to have_http_status(:success)

    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      director = Director.create! valid_attributes
      get director_url(director)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_director_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      director = Director.create! valid_attributes
      get edit_director_url(director)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Director" do
        expect {
          post directors_url, params: { director: valid_attributes }
        }.to change(Director, :count).by(1)
      end

      it "redirects to the created director" do
        post directors_url, params: { director: valid_attributes }
        expect(response).to redirect_to(director_url(Director.last))
      end
    end
  end

  describe "PATCH /update" do

    context "with valid parameters" do
      let(:new_attributes) {
        { name: "James" }
      }
      it "updates the requested director" do
        director = Director.create! valid_attributes
        patch director_url(director), params: { director: new_attributes }
        director.reload
        expect(director.name).to eq "James"
      end

      it "redirects to the director" do
        director = Director.create! valid_attributes
        patch director_url(director), params: { director: new_attributes }
        director.reload
        expect(response).to redirect_to(director_url(director))
      end
    end

  end

  describe "DELETE /destroy" do
    it "destroys the requested director" do
      director = Director.create! valid_attributes
      expect {
        delete director_url(director)
      }.to change(Director, :count).by(-1)
    end

    it "redirects to the directors list" do
      director = Director.create! valid_attributes
      delete director_url(director)
      expect(response).to redirect_to(directors_url)
    end
  end
end
