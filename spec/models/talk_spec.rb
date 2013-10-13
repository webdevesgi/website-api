require 'spec_helper'

describe Talk do
  it "has a valid factory" do
    FactoryGirl.create(:talk).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:talk, title: nil).should_not be_valid
  end
end
