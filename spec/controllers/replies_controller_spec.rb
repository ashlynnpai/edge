require 'spec_helper'

describe RepliesController do
  describe 'POST create' do
    let(:mypost) { Fabricate(:post) }
    context "with authenticated users and valid input" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        post :create, reply: Fabricate.attributes_for(:reply), post_id: mypost.id      
      end
      it "creates a new review" do
        expect(Reply.count).to eq(1)
      end
    end
  end
end