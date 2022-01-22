# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe 'POST #create' do
    it 'creates an organization' do
      request.headers.merge! headers
      post :create, params: { organization: { name: Faker::Company.name } }
      expect(response).to be_ok
    end

    it 'fails without an organization name' do
      request.headers.merge! headers
      post :create, params: { organization: { name: '' } }
      expect(response).to be_a_bad_request
    end
  end

  describe 'GET #show' do
    context 'when organization exists' do
      let!(:organization) { create(:organization) }
      let(:expected_response) do
        {
          data: {
            id: organization.id.to_s,
            type: 'organization',
            attributes: {
              name: organization.name,
              created_at: organization.created_at.as_json
            }
          }
        }
      end

      it 'returns organization json' do
        request.headers.merge! headers
        get :show, params: { id: organization.id }

        expect(response).to be_ok
        expect(json_response).to eq(expected_response)
      end
    end

    context 'when organization does not exist' do
      it 'returns 404' do
        request.headers.merge! headers
        get :show, params: { id: 1 }

        expect(response).to be_not_found
        expect(json_response).to eq(error: 'Not Found')
      end
    end
  end
end
