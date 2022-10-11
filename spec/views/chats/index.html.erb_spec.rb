require 'rails_helper'

RSpec.describe "chats/index", type: :view do
  before(:each) do
    assign(:chats, [
      Chat.create!(
        message: "Message"
      ),
      Chat.create!(
        message: "Message"
      )
    ])
  end

  it "renders a list of chats" do
    render
    assert_select "tr>td", text: "Message".to_s, count: 2
  end
end
