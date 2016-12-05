require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    @group = Group.new
  end

  it "should be valid" do
    expect(@group).to be_valid
  end
end
