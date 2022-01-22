# frozen_string_literal: true

# Exposes API for interacting with Organizations.
class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  def create
    organization = OrganizationCreator.new(
      user_id: current_user.id,
      organization_name: organization_params[:name]
    ).call
    render json: OrganizationSerializer.new(organization).serializable_hash
  rescue StandardError => e
    render json: e, status: :bad_request
  end

  def show
    @organization = Organization.find(params[:id])
    render json: OrganizationSerializer.new(@organization).serializable_hash
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end
end
