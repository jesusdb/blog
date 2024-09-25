require 'rails_helper'

RSpec.describe "reactions/edit", type: :view do
  let(:reaction) {
    Reaction.create!(
      status: 1,
      user: nil,
      reactionable_type: "MyString",
      reactionable_id: 1
    )
  }

  before(:each) do
    assign(:reaction, reaction)
  end

  it "renders the edit reaction form" do
    render

    assert_select "form[action=?][method=?]", reaction_path(reaction), "post" do

      assert_select "input[name=?]", "reaction[status]"

      assert_select "input[name=?]", "reaction[user_id]"

      assert_select "input[name=?]", "reaction[reactionable_type]"

      assert_select "input[name=?]", "reaction[reactionable_id]"
    end
  end
end
