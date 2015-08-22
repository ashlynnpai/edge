require 'spec_helper' 

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      assigns(:user).should be_new_record
    end
  end
  
  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }
      it "creates user record" do
        expect(User.count).to eq(1)
      end
      it "redirects to home" do
        expect(response).to redirect_to root_path
      end
    end
    
    context "with invalid input" do
      before { post :create, user: {password: "password"} }
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end
  
  describe "GET show" do
    it "sets @user" do
      user = Fabricate(:user)
      get :show, id: user.slug
      expect(assigns(:user)).to eq(user)
    end
  end
  
  describe "GET transcript" do
    it "sets @user" do
      user = Fabricate(:user)
      get :transcript, id: user.slug
      expect(assigns(:user)).to eq(user)
    end
  end
  
  describe "GET points" do
    it "sets @user" do
      user = Fabricate(:user)
      get :points, id: user.slug
      expect(assigns(:user)).to eq(user)
    end
  end
  
  describe "GET badges" do
    it "sets @user" do
      user = Fabricate(:user)
      get :badges, id: user.slug
      expect(assigns(:user)).to eq(user)
    end
  end
  
  describe "make private" do
    context "with authenticated user" do
      let(:user){ Fabricate(:user, public_profile: true) }
      before {session[:user_id] = user.id}
      it "redirects to the user path" do
        patch :make_private, id: user.id, user: {public_profile: false}
        expect(response).to redirect_to dashboard_path
      end
      it "sets the flash success message" do
        patch :make_private, id: user.id, user: {public_profile: false}
        expect(flash[:success]).to be_present
      end
      it "sets the user profile to false" do
        patch :make_private, id: user.id, user: {public_profile: false}
        expect(user.reload.public_profile).to eq(false)
      end
    end
    context "with unauthenticated user" do
      let(:user){ Fabricate(:user, public_profile: true) }
      it "redirects to the root path" do
        patch :make_private, id: user.id, user: {public_profile: false}
        expect(response).to redirect_to root_path
      end
      it "does not set the user profile to false" do
        patch :make_private, id: user.id, user: {public_profile: false}
        expect(user.reload.public_profile).to eq(true)
      end
    end
    context "with the incorrect user in the session" do
      let(:user){ Fabricate(:user) }
      let(:current_user){ Fabricate(:user) }
      before {session[:current_user_id] = user.id}
      it "redirects to the root path" do
        patch :make_private, id: user.id, user: {public_profile: false}
        expect(response).to redirect_to root_path
      end
      it "does not set the user profile to false" do
        patch :make_private, id: user.id, user: {public_profile: false}
        expect(user.reload.public_profile).to eq(true)
      end
    end
    describe "make public" do
      let(:user){ Fabricate(:user) }
      it "redirects to the user path" do
        patch :make_public, id: user.id, user: {public_profile: true}
        expect(response).to redirect_to dashboard_path
      end
    end
  end
end
  