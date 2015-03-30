require 'spec_helper'

describe BadgeinputsController do
  describe 'GET new' do
    context 'authenticated user' do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end
      it 'sets @badgeinput' do
        get :new
        expect(assigns(:badgeinput)).to be_a_new(Badgeinput)
      end
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
      it 'creates badgeinput record' do
        post :create, badgeinput: Fabricate.attributes_for(:badgeinput)
        expect(Badgeinput.count).to eq(1)
      end  
      it 'sets the flash success message' do
        post :create, badgeinput: Fabricate.attributes_for(:badgeinput)
        expect(flash[:success]).not_to be_blank
      end
    end
  
    context 'with no authenticated user' do
      it 'does not create course record' do
        post :create, badgeinput: Fabricate.attributes_for(:badgeinput)
        expect(Course.count).to eq(0)
      end  
      it 'expects a redirect to login' do
        post :create, badgeinput: Fabricate.attributes_for(:badgeinput)
        expect(response).to redirect_to login_path
      end
    end
  end
end

