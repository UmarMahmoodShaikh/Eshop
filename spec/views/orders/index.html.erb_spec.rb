require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        status: false
      ),
      Order.create!(
        status: false
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
