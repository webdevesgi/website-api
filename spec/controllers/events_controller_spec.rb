require 'spec_helper'

describe EventsController do

  describe "GET #index" do
    it "populates an array of events" do
      FactoryGirl.create_list(:event, 10)
      get :index
      expect(response).to be_success
    end

    it "renders the correct number of events" do
      FactoryGirl.create_list(:event, 10)
      get :index
      json = JSON.parse(response.body)
      expect(json.length).to eq(10)
    end

    it "includes an array 'talks' key" do
      event = FactoryGirl.create(:event)
      get :index
      json = JSON.parse response.body
      expect(json.first.include?('talks')).to be_true
      talks = json.first['talks']
      expect(talks.kind_of?(Array)).to be_true
    end
  end

  describe "GET #show" do
    it "assigns the requested event to @event" do
      event = FactoryGirl.create(:event)
      get :show, id: event
     assigns(:event).should eq(event)
    end

    it "renders the :show view" do
      event = FactoryGirl.create(:event)
      get :show, id: event
      json = JSON.parse(response.body)
      expect(json['title']).to eq(event.title)
    end

    it "includes an array 'talks' key" do
      event = FactoryGirl.create(:event)
      get :show, id: event
      json = JSON.parse response.body
      expect(json.include?('talks')).to be_true
      talks = json['talks']
      expect(talks.kind_of?(Array)).to be_true
    end
  end

  describe "GET #past_events" do
    it "renders only past events" do
      correct_number = 2
      FactoryGirl.create_list(:event, 10)
      FactoryGirl.create_list(:past_event, correct_number)
      get :past_events
      json = JSON.parse(response.body)
      expect(json.length).to eq(correct_number)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new event in the database" do
        user = FactoryGirl.create(:user)
        expect{
          post :create, access_token: user.token,
                        event:  FactoryGirl
                                .build(:event)
                                .attributes
                                .except('id', 'created_at', 'updated_at')
        }.to change(Event,:count).by(1)
      end

      it "renders the created event" do
        user = FactoryGirl.create(:user)
        event = FactoryGirl.build(:event)
        post :create, access_token: user.token,
                      event:  event
                              .attributes
                              .except('id', 'created_at', 'updated_at')
        json = JSON.parse(response.body)
        expect(json['title']).to eq(event.title)
      end
    end

    context "with invalid attributes" do
      it "does not save the new event in the database" do
        expect{
          post :create, event: FactoryGirl.attributes_for(:invalid_event)
        }.to_not change(Event,:count)
      end

      it "renders error response" do
        post :create, event: FactoryGirl.attributes_for(:invalid_event)
        response.code.should_not eq('200')
      end
    end
  end
end
