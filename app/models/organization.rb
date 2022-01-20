# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects

  has_many :user_organizations, dependent: :destroy
  has_many :users, through: :user_organizations

  validates :name, presence: true
end
