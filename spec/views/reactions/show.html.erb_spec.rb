require 'rails_helper'

RSpec.describe "reactions/show", type: :view do
  before(:each) do
    assign(:reaction, Reaction.create!(
      status: 2,
      user: nil,
      reactionable_type: "Reactionable Type",
      reactionable_id: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Reactionable Type/)
    expect(rendered).to match(/3/)
  end
end
