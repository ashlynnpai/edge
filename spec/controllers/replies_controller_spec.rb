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
  
  describe "GET edit" do
    
    context "with the user's own reply" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      let(:mypost) { Fabricate(:post) }
        it "assigns @reply" do
          reply = Fabricate(:reply, post_id: mypost.id, user_id: current_user.id)
          get :edit, post_id: mypost.id, id: reply.id
          expect(assigns(:reply)).to eq(reply)
        end       
     end
    
     context "with another's reply" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      let(:mypost) { Fabricate(:post) }
      let(:reply_author) { Fabricate(:user) }
        it "redirects the unauthorized user to the course path" do
          reply = Fabricate(:reply, post_id: mypost.id, user_id: reply_author.id)
          get :edit, post_id: mypost.id, id: reply.id
          expect(response).to redirect_to post_path(mypost)
        end       
     end
  end
  
  describe "PUT update" do
    
    context "with the user's own reply" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      let(:mypost) { Fabricate(:post) }
      it "updates the reply" do
        reply = Fabricate(:reply, post_id: mypost.id, content: "old reply", user_id: current_user.id)
        put :update, post_id: mypost.id, id: reply.id, reply: {content: "new reply"}
        expect(reply.reload.content).to eq("new reply")
      end   
      it "sets the flash success message" do
        reply = Fabricate(:reply, post_id: mypost.id, content: "old reply", user_id: current_user.id)
        put :update, post_id: mypost.id, id: reply.id, reply: {content: "new reply"}
        expect(flash[:success]).not_to be_blank
      end
    end
    
    context "with an unauthorized user" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      let(:mypost) { Fabricate(:post) }
      let(:reply_author) { Fabricate(:user) }
      it "does not update the reply" do
        reply = Fabricate(:reply, post_id: mypost.id, content: "old reply", user_id: reply_author.id)
        put :update, post_id: mypost.id, id: reply.id, reply: {content: "new reply"}
        expect(reply.reload.content).to eq("old reply")
      end   
      it "redirects to the post path" do
        reply = Fabricate(:reply, post_id: mypost.id, content: "old reply", user_id: reply_author.id)
        put :update, post_id: mypost.id, id: reply.id, reply: {content: "new reply"}
        expect(response).to redirect_to post_path(mypost)
      end
    end
  end
end

