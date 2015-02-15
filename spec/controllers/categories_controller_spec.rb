require 'spec_helper'

describe CategoriesController do
  describe 'GET new' do
    it 'sets @category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end
  describe 'POST create' do
    it 'creates category record' do
      post :create, category: Fabricate.attributes_for(:category)
      expect(Category.count).to eq(1)
      end  
    it 'sets the flash success message' do
      post :create, category: Fabricate.attributes_for(:category)
      expect(flash[:success]).not_to be_blank
    end
  end
  describe "GET show" do
    it "sets @category" do
      category = Fabricate(:category)
      get :show, id: category.slug
      expect(assigns(:category)).to eq(category)
    end
    it "renders the template show" do
      category = Fabricate(:category)
      get :show, id: category.slug
      expect(response).to render_template :show
    end
    it "redirects to root path for an invalid slug" do
      category = Fabricate(:category, slug: "good-slug")
      get :show, id: "bad-slug"
      expect(response).to redirect_to root_path
    end
  end
end