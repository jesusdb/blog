require 'rails_helper'

RSpec.describe "reactions/index", type: :view do
  before(:each) do
    assign(:reactions, [
      Reaction.create!(
        status: 2,
        user: nil,
        reactionable_type: "Reactionable Type",
        reactionable_id: 3
      ),
      Reaction.create!(
        status: 2,
        user: nil,
        reactionable_type: "Reactionable Type",
        reactionable_id: 3
      )
    ])
  end

  it "renders a list of reactions" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Reactionable Type".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
