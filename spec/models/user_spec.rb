require 'spec_helper'

describe User do
  it "has a valid factory" do
    user = FactoryGirl.build(:user)
    user.should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:invalid_user_name).should_not be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:invalid_user_email_present).should_not be_valid
  end

  it "is invalid with a wrong email" do
    FactoryGirl.build(:invalid_user_email_syntax).should_not be_valid
  end

  it "is invalid without a password" do
    FactoryGirl.build(:invalid_user_password).should_not be_valid
  end

  it "is invalid with a too-short password" do
    FactoryGirl.build(:invalid_user_password_length).should_not be_valid
  end
end
