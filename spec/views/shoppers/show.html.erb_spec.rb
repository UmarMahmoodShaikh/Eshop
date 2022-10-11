require 'rails_helper'

RSpec.describe "shoppers/show", type: :view do
  before(:each) do
    @shopper = assign(:shopper, Shopper.create!(
      name: "Name",
      email: "Email",
      pass: "Pass",
      phone: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Pass/)
    expect(rendered).to match(/MyText/)
  end
end
