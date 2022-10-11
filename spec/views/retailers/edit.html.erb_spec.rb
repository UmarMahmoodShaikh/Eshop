require 'rails_helper'

RSpec.describe "retailers/edit", type: :view do
  before(:each) do
    @retailer = assign(:retailer, Retailer.create!(
      name: "MyString",
      email: "MyString",
      pass: "MyString",
      phone: "MyText",
      address: "MyText"
    ))
  end

  it "renders the edit retailer form" do
    render

    assert_select "form[action=?][method=?]", retailer_path(@retailer), "post" do

      assert_select "input[name=?]", "retailer[name]"

      assert_select "input[name=?]", "retailer[email]"

      assert_select "input[name=?]", "retailer[pass]"

      assert_select "textarea[name=?]", "retailer[phone]"

      assert_select "textarea[name=?]", "retailer[address]"
    end
  end
end
