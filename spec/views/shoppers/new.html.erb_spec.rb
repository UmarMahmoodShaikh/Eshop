require 'rails_helper'

RSpec.describe "shoppers/new", type: :view do
  before(:each) do
    assign(:shopper, Shopper.new(
      name: "MyString",
      email: "MyString",
      pass: "MyString",
      phone: "MyText"
    ))
  end

  it "renders new shopper form" do
    render

    assert_select "form[action=?][method=?]", shoppers_path, "post" do

      assert_select "input[name=?]", "shopper[name]"

      assert_select "input[name=?]", "shopper[email]"

      assert_select "input[name=?]", "shopper[pass]"

      assert_select "textarea[name=?]", "shopper[phone]"
    end
  end
end
