# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #account' do
    it 'is a logged in user' do
      request.headers.merge! headers
      get :show
      expect(response).to be_ok
    end

    it 'is not a logged in user' do
      get :show
      expect(response).to be_unauthorized
    end
  end
end
