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
end