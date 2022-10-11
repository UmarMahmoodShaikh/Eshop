require 'rails_helper'

RSpec.describe "retailers/index", type: :view do
  before(:each) do
    assign(:retailers, [
      Retailer.create!(
        name: "Name",
        email: "Email",
        pass: "Pass",
        phone: "MyText",
        address: "MyText"
      ),
      Retailer.create!(
        name: "Name",
        email: "Email",
        pass: "Pass",
        phone: "MyText",
        address: "MyText"
      )
    ])
  end

  it "renders a list of retailers" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Pass".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
