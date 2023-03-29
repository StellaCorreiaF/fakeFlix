require 'rails_helper'

RSpec.describe "directors/edit", type: :view do
  let(:director) {
    Director.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:director, director)
  end

  it "renders the edit director form" do
    render

    assert_select "form[action=?][method=?]", director_path(director), "post" do

      assert_select "input[name=?]", "director[name]"
    end
  end
end
