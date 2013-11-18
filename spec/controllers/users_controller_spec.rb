require 'spec_helper'

describe UsersController do

  before :each do
    @user = FactoryGirl.create(:user)
  end

  describe "GET #index" do
    it "populates an array of users" do
      FactoryGirl.create_list(:user, 9) # + 1 created user in before method == 10
      get :index, access_token: @user.token
      expect(response).to be_success
    end

    it "renders the correct number of users" do
      FactoryGirl.create_list(:user, 9) # + 1 created user in before method == 10
      get :index, access_token: @user.token
      json = JSON.parse(response.body)
      expect(json.length).to eq(10)
    end
  end

  describe "GET #show" do
    it "assigns the requested user to @user" do
      user = FactoryGirl.create(:user)
      get :show, access_token: @user.token, id: user
      assigns(:user).should eq(user)
    end

    it "renders the :show view" do
      user = FactoryGirl.create(:user)
      get :show, access_token: @user.token, id: user
      json = JSON.parse(response.body)
      expect(json['name']).to eq(user.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new user in the database" do
        expect{
          post :create, user:  FactoryGirl
                                .build(:user)
                                .attributes
                                .except('id', 'created_at', 'updated_at')
        }.to change(User,:count).by(1)
      end

      it "renders the created user" do
        user = FactoryGirl.build(:user)
        post :create, user:  user
                              .attributes
                              .except('id', 'created_at', 'updated_at')
        json = JSON.parse(response.body)
        expect(json['name']).to eq(user.name)
      end
    end

    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:invalid_user_password_length)
        }.to_not change(User, :count)
      end

      it "renders error response" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user_password_length)
        response.code.should_not eq('200')
      end
    end
  end
end
