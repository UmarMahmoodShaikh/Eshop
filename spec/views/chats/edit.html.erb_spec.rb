require 'rails_helper'

RSpec.describe "chats/edit", type: :view do
  before(:each) do
    @chat = assign(:chat, Chat.create!(
      message: "MyString"
    ))
  end

  it "renders the edit chat form" do
    render

    assert_select "form[action=?][method=?]", chat_path(@chat), "post" do

      assert_select "input[name=?]", "chat[message]"
    end
  end
end
