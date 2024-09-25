require 'rails_helper'

RSpec.describe "reactions/new", type: :view do
  before(:each) do
    assign(:reaction, Reaction.new(
      status: 1,
      user: nil,
      reactionable_type: "MyString",
      reactionable_id: 1
    ))
  end

  it "renders new reaction form" do
    render

    assert_select "form[action=?][method=?]", reactions_path, "post" do

      assert_select "input[name=?]", "reaction[status]"

      assert_select "input[name=?]", "reaction[user_id]"

      assert_select "input[name=?]", "reaction[reactionable_type]"

      assert_select "input[name=?]", "reaction[reactionable_id]"
    end
  end
end
