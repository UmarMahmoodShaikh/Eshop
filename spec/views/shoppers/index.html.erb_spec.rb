require 'rails_helper'

RSpec.describe "shoppers/index", type: :view do
  before(:each) do
    assign(:shoppers, [
      Shopper.create!(
        name: "Name",
        email: "Email",
        pass: "Pass",
        phone: "MyText"
      ),
      Shopper.create!(
        name: "Name",
        email: "Email",
        pass: "Pass",
        phone: "MyText"
      )
    ])
  end

  it "renders a list of shoppers" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Pass".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
