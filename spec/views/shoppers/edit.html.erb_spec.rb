require 'rails_helper'

RSpec.describe "shoppers/edit", type: :view do
  before(:each) do
    @shopper = assign(:shopper, Shopper.create!(
      name: "MyString",
      email: "MyString",
      pass: "MyString",
      phone: "MyText"
    ))
  end

  it "renders the edit shopper form" do
    render

    assert_select "form[action=?][method=?]", shopper_path(@shopper), "post" do

      assert_select "input[name=?]", "shopper[name]"

      assert_select "input[name=?]", "shopper[email]"

      assert_select "input[name=?]", "shopper[pass]"

      assert_select "textarea[name=?]", "shopper[phone]"
    end
  end
end
