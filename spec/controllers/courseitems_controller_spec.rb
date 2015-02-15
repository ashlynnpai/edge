require 'spec_helper'

describe CourseitemsController do
  describe "POST create" do
    context "with authenticated user" do
      let(:user) { Fabricate(:user) }
      let(:course) { Fabricate(:course) }
      before do
        session[:user_id] = user.id
      end
      it "sets @course" do
        post :create, course_id: course.slug
        expect(assigns(:course)).to eq(course)
      end     
      it "creates a queue item" do
        post :create, course_id: course.slug
        expect(Courseitem.count).to eq(1)
      end
      it "creates the queue item associated with the course" do
        post :create, course_id: course.slug
        expect(Courseitem.first.course).to eq(course)      
      end
      it "creates the queue item associated with the logged in user" do
        post :create, course_id: course.slug
        expect(Courseitem.first.user).to eq(user)   
      end
    end
  end
end