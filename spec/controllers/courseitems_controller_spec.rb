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
      it "does not create a new course if it is already in the list" do
        Fabricate(:courseitem, course: course, user: user)
        post :create, course_id: course.slug
        expect(Courseitem.count).to eq(1)
      end
      it "puts a new course item in the last position" do
        first = Fabricate(:course)
        Fabricate(:courseitem, course: first, user: user)
        second = Fabricate(:course)
        Fabricate(:courseitem, course: second, user: user)
        post :create, course_id: course.slug
        expect(Courseitem.last.position).to eq(3)
      end
    end
  end
end


 