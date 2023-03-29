require 'rails_helper'

RSpec.describe "movies/new", type: :view do
  before(:each) do
    assign(:movie, Movie.new(
      title: "MyString",
      duration: 1,
      year: 1,
      resume: "MyText"
    ))
  end

  it "renders new movie form" do
    render

    assert_select "form[action=?][method=?]", movies_path, "post" do

      assert_select "input[name=?]", "movie[title]"

      assert_select "input[name=?]", "movie[duration]"

      assert_select "input[name=?]", "movie[year]"

      assert_select "textarea[name=?]", "movie[resume]"
    end
  end
end
