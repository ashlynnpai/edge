require 'spec_helper'

describe CoursesController do
  describe 'GET new' do
    it_behaves_like "requires sign in" do
      let(:action) {get :new}
    end
    it 'sets @course' do
      set_current_user
      get :new
      expect(assigns(:course)).to be_a_new(Course)
    end
  end
  
  describe 'POST create' do
    it_behaves_like "requires sign in" do
      let(:action) {post :create}
    end
    context 'with valid data and authenticated user' do
        let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
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
      it 'creates a usercourse record with the current user id' do
        post :create, course: Fabricate.attributes_for(:course)
        expect(UserCourse.first.user_id).to eq(user.id)
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
       it 'does not create course record' do
         post :create, course: Fabricate.attributes_for(:course)
         expect(Course.count).to eq(0)
      end  
       it 'expects a redirect to login' do
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
      expect(response).to render_template :show
    end
    it "redirects to root path for an invalid slug" do
      course = Fabricate(:course, slug: "good-slug")
      get :show, id: "bad-slug"
      expect(response).to redirect_to root_path
    end
    it "renders show for a valid slug" do
      course = Fabricate(:course, slug: "good-slug")
      get :show, id: course.slug
      expect(response).to render_template :show
    end
    it "sets @review" do
      set_current_user
      course = Fabricate(:course)
      get :show, id: course.slug
      expect(assigns(:review)).to be_a_new(Review)
    end
  end
  describe "POST add_course_status" do
    it_behaves_like "requires sign in" do
      let(:action) {post :add_course_status}
    end
    context 'with authenticated user' do
      let(:user) { Fabricate(:user) }
      let(:course) { Fabricate(:course) }
      before do
        session[:user_id] = user.id
      end
      it 'creates the join table usercourse record if one does not exist' do
        post :add_course_status, user_id: user.id, course_id: course.slug
        expect(UserCourse.count).to eq(1)
      end
      it 'creates a record with the current user id' do
        post :add_course_status, user_id: user.id, course_id: course.slug
        expect(UserCourse.first.user_id).to eq(user.id)
      end
      it 'creates a record with the course id' do
        post :add_course_status, user_id: user.id, course_id: course.slug
        expect(UserCourse.first.course_id).to eq(course.id)
      end
      it 'sets the course status to completed' do
        post :add_course_status, user_id: user.id, course_id: course.slug, status: "completed"
        expect(UserCourse.first.status).to eq('completed')
      end
      it 'sets the flash success message' do
        post :add_course_status, user_id: user.id, course_id: course.slug
        expect(flash[:success]).not_to be_blank
      end
      it 'does not create a new usercourse record if one already exists' do
        UserCourse.create(user_id: user.id, course_id: course.id)
        post :add_course_status, user_id: user.id, course_id: course.slug
        expect(UserCourse.count).to eq(1)
      end
      it 'updates the column on the existing record' do
        UserCourse.create(user_id: user.id, course_id: course.id, status: nil)
        post :add_course_status, user_id: user.id, course_id: course.slug, status: "current"
        expect(UserCourse.first.status).to eq('current')
      end
    end
  end
  describe "GET study_hall" do
    it "sets @course" do
      course = Fabricate(:course)
      get :study_hall, id: course.slug
      expect(assigns(:course)).to eq(course)
    end
    it "redirects to root path for an invalid slug" do
      course = Fabricate(:course, slug: "good-slug")
      get :study_hall, id: "bad-slug"
      expect(response).to redirect_to root_path
    end
    it "sets @post" do
      course = Fabricate(:course)
      get :study_hall, id: course.slug
      expect(assigns(:post)).to be_a_new(Post)
    end   
  end
end