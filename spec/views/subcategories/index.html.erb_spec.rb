require 'rails_helper'

RSpec.describe "subcategories/index", type: :view do
  before(:each) do
    assign(:subcategories, [
      Subcategory.create!(
        name: "Name"
      ),
      Subcategory.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of subcategories" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
