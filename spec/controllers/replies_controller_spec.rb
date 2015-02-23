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
      it "creates a review associated with the post" do
        expect(Reply.first.post).to eq(mypost)
      end
      it "creates a review associated with the signed in user" do
        expect(Reply.first.creator).to eq(current_user)
      end
      it "sets the flash success message" do
        expect(flash[:success]).not_to be_blank
      end
      it "redirects to show course" do         
        expect(response).to redirect_to post_path(mypost)
      end
    end
    context "with unauthenticated users" do
      it "redirects to sign in path" do
        post :create, reply: Fabricate.attributes_for(:reply), post_id: mypost.id    
        expect(response).to redirect_to login_path
      end
    end
    context "with invalid input" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
      end
      it "renders the 'posts/show' template" do
        post :create, reply: Fabricate.attributes_for(:reply, content: nil), post_id: mypost.id   
        expect(response).to render_template('posts/show')
      end
    end
  end
end

