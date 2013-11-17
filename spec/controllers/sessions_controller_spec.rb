require 'spec_helper'

describe SessionsController do

  describe "POST 'auth'" do
    it "returns http success" do
      user = FactoryGirl.create(:user_with_clear_password)
      post 'auth', :user => {name: user.name, password: user.name}
      response.should be_success
    end
  end

end
