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
  describe "GET edit" do
    context "with the user's own review" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      let(:course) { Fabricate(:course) }
        it "assigns @review" do
          review = Fabricate(:review, course_id: course.id, user_id: current_user.id)
          get :edit, course_id: course.id, id: review.id
          expect(assigns(:review)).to eq(review)
        end       
     end
    context "with another's review" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      let(:course) { Fabricate(:course) }
      let(:reviewer) { Fabricate(:user) }
      it "redirects the unauthorized user to the course path" do
          review = Fabricate(:review, course_id: course.id, user_id: reviewer.id)
          get :edit, course_id: course.id, id: review.id
          expect(response).to redirect_to course_path(course)
        end       
     end
  end
  describe "PUT update" do
    context "with the user's own review" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      let(:course) { Fabricate(:course) }
      it "updates the review" do
        review = Fabricate(:review, course_id: course.id, content: "old review", user_id: current_user.id)
        put :update, course_id: course.id, id: review.id, review: {content: "new review"}
        expect(review.reload.content).to eq("new review")
      end   
      it "sets the flash success message" do
        review = Fabricate(:review, course_id: course.id, content: "old review", user_id: current_user.id)
        put :update, course_id: course.id, id: review.id, review: {content: "new review"}
        expect(flash[:success]).not_to be_blank
      end
    end
  end
end