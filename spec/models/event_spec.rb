require 'spec_helper'

describe Event do
  it "has a valid factory" do
    FactoryGirl.create(:event).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:event, title: nil).should_not be_valid
  end

  it { should have_many(:talks) }

  it "can add a talk" do
    event = FactoryGirl.create(:event)
    talk = FactoryGirl.create(:talk)
    event.talks << talk
    event.save
    event.talks.size.should eq(1)
  end
end
