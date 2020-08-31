require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'before_action' do
    it { should use_before_action(:require_user) }
  end
  describe 'GET #index' do
    before do
      User.create(username: 'somoye')
      session[:author_id] = 1
      get :index
    end
    it { should render_template('index') }
  end
end
