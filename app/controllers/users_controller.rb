# frozen_string_literal: true

# Exposes API for interacting with the Users.
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: UserSerializer.new(current_user).serializable_hash
  end
end
