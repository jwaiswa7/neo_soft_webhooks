# frozen_string_literal: true

RSpec.shared_context 'with Auth Header' do
  let(:user) { FactoryBot.create :user }
  let(:auth_headers) { user.create_new_auth_token }
  let(:headers) do
    {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json',
      'Uid' => auth_headers['uid'],
      'Access-Token' => auth_headers['access-token'],
      'Client' => auth_headers['client']
    }
  end
end

RSpec.configure do |config|
  config.include_context 'with Auth Header'
end
