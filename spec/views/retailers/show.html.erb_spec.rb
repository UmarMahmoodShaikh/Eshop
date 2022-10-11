require 'rails_helper'

RSpec.describe "retailers/show", type: :view do
  before(:each) do
    @retailer = assign(:retailer, Retailer.create!(
      name: "Name",
      email: "Email",
      pass: "Pass",
      phone: "MyText",
      address: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Pass/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
