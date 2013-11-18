require 'spec_helper'

describe TalksController do

  before :each do
    @user = FactoryGirl.create(:user)
  end

  describe "GET #index" do
    it "populates an array of talks" do
      FactoryGirl.create_list(:talk, 10)
      get :index, access_token: @user.token
      expect(response).to be_success
    end

    it "renders the correct number of talks" do
      FactoryGirl.create_list(:talk, 10)
      get :index, access_token: @user.token
      json = JSON.parse(response.body)
      expect(json.length).to eq(10)
    end

    it "includes an array 'event_id' key" do
      talk = FactoryGirl.create(:talk)
      get :index, access_token: @user.token
      json = JSON.parse response.body
      expect(json.first.include?('event_id')).to be_true
    end
  end

  describe "GET #show" do
    it "assigns the requested event to @talk" do
      talk = FactoryGirl.create(:talk)
      get :show,  access_token: @user.token,
                  id: talk
     assigns(:talk).should eq(talk)
    end

    it "renders the :show view" do
      talk = FactoryGirl.create(:talk)
      get :show,  access_token: @user.token,
                  id: talk
      json = JSON.parse(response.body)
      expect(json['title']).to eq(talk.title)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new talk in the database" do
        expect{
          post :create, access_token: @user.token,
                        talk:   FactoryGirl
                                .build(:talk)
                                .attributes
        }.to change(Talk, :count).by(1)
      end

      it "renders the created talk" do
        talk = FactoryGirl.build(:talk)
        post :create, access_token: @user.token,
                      talk: talk.attributes
        json = JSON.parse(response.body)
        expect(json['title']).to eq(talk.title)
      end
    end

    context "with invalid attributes" do
      it "does not save the new talk in the database" do
        expect{
          post :create, access_token: @user.token,
                        talk: FactoryGirl.attributes_for(:invalid_talk)
        }.to_not change(Talk, :count)
      end

      it "renders error response" do
        post :create, access_token: @user.token,
                      talk: FactoryGirl.attributes_for(:invalid_talk)
        response.code.should_not eq('200')
      end
    end
  end
end
