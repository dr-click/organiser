require 'rails_helper'

RSpec.describe "home/index.html.haml", type: :view do
  before(:each) do
  end

  it "renders home index view" do
    render
    response.should include("After creating a dozen or so Ruby on Rails app")
  end
end
