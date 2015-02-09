require 'spec_helper'

describe CoursesController do
  before {set_current_user}
  describe 'GET new' do
    it 'sets @course' do
      get :new
      expect(assigns(:course)).to be_instance_of Course
      expect(assigns(:course)).to be_new_record
    end
  end
  
  describe 'POST create' do
    context 'with valid data and authenticated user' do
      before do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
      end
      it 'creates course record' do
        post :create, course: Fabricate.attributes_for(:course)
        expect(Course.count).to eq(1)
      end  
      it 'sets the flash success message' do
        post :create, course: Fabricate.attributes_for(:course)
        expect(flash[:success]).not_to be_blank
      end
      it 'creates the join table usercourse record' do
        post :create, course: Fabricate.attributes_for(:course)
        expect(UserCourse.count).to eq(1)
      end
      it 'creates a record with the current user id' do
        post :create, course: Fabricate.attributes_for(:course)
        expect(UserCourse.first.user_id).to eq(@user.id)
      end
      it 'sets the course creator field to true' do
        post :create, course: Fabricate.attributes_for(:course)
        expect(UserCourse.first.course_creator).to eq(true)
      end
    end
    context 'with invalid data and authenticated user' do
       before {set_current_user}
       it 'does not create course record' do
         post :create, course: Fabricate.attributes_for(:course, provider: nil)
         expect(Course.count).to eq(0)
      end  
       it 'sets the flash error message' do
         post :create, course: Fabricate.attributes_for(:course, provider: nil)
         expect(flash[:danger]).not_to be_blank
       end
       it 'expects render new' do
         post :create, course: Fabricate.attributes_for(:course, provider: nil)
         expect(response).to render_template 'new'
       end
       it 'does not create the join table usercourse record' do
         post :create, course: Fabricate.attributes_for(:course, provider: nil)
         expect(UserCourse.count).to eq(0)
       end
    end
    context 'with no authenticated user' do
       before { session[:user_id] = nil }
       it 'does not create course record' do
         post :create, course: Fabricate.attributes_for(:course)
         expect(Course.count).to eq(0)
      end  
       it 'expects render new' do
         post :create, course: Fabricate.attributes_for(:course)
         expect(response).to redirect_to login_path
       end
       it 'does not create the join table usercourse record' do
         post :create, course: Fabricate.attributes_for(:course)
         expect(UserCourse.count).to eq(0)
       end
    end
  end
  
  describe "GET show" do
    it "sets @course" do
      course = Fabricate(:course)
      get :show, id: course.slug
      expect(assigns(:course)).to eq(course)
    end
    it "renders the template show" do
      course = Fabricate(:course)
      get :show, id: course.slug
      expect(assigns).to render_template :show
    end
  end
end