require 'rails_helper'

RSpec.describe "directors/show", type: :view do
  before(:each) do
    assign(:director, Director.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
