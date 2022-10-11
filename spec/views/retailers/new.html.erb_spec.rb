require 'rails_helper'

RSpec.describe "retailers/new", type: :view do
  before(:each) do
    assign(:retailer, Retailer.new(
      name: "MyString",
      email: "MyString",
      pass: "MyString",
      phone: "MyText",
      address: "MyText"
    ))
  end

  it "renders new retailer form" do
    render

    assert_select "form[action=?][method=?]", retailers_path, "post" do

      assert_select "input[name=?]", "retailer[name]"

      assert_select "input[name=?]", "retailer[email]"

      assert_select "input[name=?]", "retailer[pass]"

      assert_select "textarea[name=?]", "retailer[phone]"

      assert_select "textarea[name=?]", "retailer[address]"
    end
  end
end
