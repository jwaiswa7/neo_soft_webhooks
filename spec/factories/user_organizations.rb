# frozen_string_literal: true

FactoryBot.define do
  factory :user_organization do
    user
    organization
  end
end
