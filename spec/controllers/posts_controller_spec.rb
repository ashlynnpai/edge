require 'spec_helper'

describe PostsController do
  describe 'POST create' do
    let(:course) { Fabricate(:course) }
    context "with authenticated users and valid input" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        post :create, post: Fabricate.attributes_for(:post), course_id: course.slug
      end
      it "creates a new post" do
        expect(Post.count).to eq(1)
      end
      it "creates a post associated with the course" do
        expect(Post.first.course).to eq(course)
      end
      it "creates a post associated with the signed in user" do
        expect(Post.first.creator).to eq(current_user)
      end
      it "sets the flash success message" do
        expect(flash[:success]).not_to be_blank
      end
      it "redirects to study hall path" do         
        expect(response).to redirect_to study_hall_path(course)
      end
    end
    context "with unauthenticated users" do
      it "redirects to sign in path" do
        post :create, post: Fabricate.attributes_for(:post), course_id: course.slug
        expect(response).to redirect_to login_path
      end
    end
    context "with invalid input" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
      end
      it "renders the study hall template" do
        post :create, post: Fabricate.attributes_for(:post, content: nil), course_id: course.slug
        expect(response).to render_template('courses/study_hall')
      end
    end
  end
  
  describe 'GET show' do
    let(:post) { Fabricate(:post) }
    it "sets @post" do
      get :show, id: post.id
      expect(assigns(:post)).to eq(post)
    end
  end
  
  describe "GET edit" do
    context "with the user's own post" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      let(:course) { Fabricate (:course) }
      it "sets @post" do
        mypost = Fabricate(:post, course_id: course.id, content: "old post", user_id: current_user.id)
        get :edit, course_id: course.id, id: mypost.id, post: {content: "new post"}
        expect(assigns(:post)).to eq(mypost)
      end
    end
    context "with another user's post" do
      let(:current_user) { Fabricate(:user) }
      let(:post_creator) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      let(:course) { Fabricate(:course) }
      it "redirects to the root path" do
        mypost = Fabricate(:post, course_id: course.id, content: "old post", user_id: post_creator.id)
        get :edit, course_id: course.id, id: mypost.id, post: {content: "new post"}
        expect(response).to redirect_to root_path
      end   
    end
  end
  
  describe "PUT update" do
    context "with the user's own post" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      let(:course) { Fabricate(:course) }
      it "updates the post" do
        mypost = Fabricate(:post, course_id: course.id, content: "old post", user_id: current_user.id)
        put :update, course_id: course.id, id: mypost.id, post: {content: "new post"}
        expect(mypost.reload.content).to eq("new post")
      end   
      it "sets the flash success message" do
        mypost = Fabricate(:post, course_id: course.id, content: "old post", user_id: current_user.id)
        put :update, course_id: course.id, id: mypost.id, post: {content: "new post"}
        expect(flash[:success]).not_to be_blank
      end
    end
  end
end
