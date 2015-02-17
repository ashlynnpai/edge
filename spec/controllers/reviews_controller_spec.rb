require 'spec_helper'

describe ReviewsController do
  describe 'POST create' do
    let(:course) { Fabricate(:course) }
    context "with authenticated users and valid input" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        post :create, review: Fabricate.attributes_for(:review), course_id: course.slug
      end
      it "creates a new review" do
        expect(Review.count).to eq(1)
      end
      it "creates a review associated with the course" do
        expect(Review.first.course).to eq(course)
      end
      it "creates a review associated with the signed in user" do
        expect(Review.first.creator).to eq(current_user)
      end
      it "sets the flash success message" do
        expect(flash[:success]).not_to be_blank
      end
      it "redirects to show course" do         
        expect(response).to redirect_to course_path(course)
      end
    end
    context "with unauthenticated users" do
      it "redirects to sign in path" do
        post :create, review: Fabricate.attributes_for(:review), course_id: course.slug
        expect(response).to redirect_to login_path
      end
    end
    context "with invalid input" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
      end
      it "renders the courses/show template" do
        post :create, review: Fabricate.attributes_for(:review, content: nil), course_id: course.slug
        expect(response).to render_template('courses/show')
      end
    end
  end
end