require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        name: "Name",
        age: 2
      ),
      User.create!(
        name: "Name",
        age: 2
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "#users div[id^=user_] p>strong", text: "名前:", count: 2
    assert_select "#users div[id^=user_] p", text: /Name/, count: 2
    assert_select "#users div[id^=user_] p>strong", text: "年齢:", count: 2
    assert_select "#users div[id^=user_] p", text: /2/, count: 2
  end
end
