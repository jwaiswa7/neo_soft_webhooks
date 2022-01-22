# frozen_string_literal: true

# Exposes API for interacting with Organizations.
class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  def create
    organization_create = OrganizationCreator.new(
      user_id: current_user.id,
      organization_name: organization_params[:name]
    ).call
    
    if organization_create[:status]
     render json: OrganizationSerializer.new(organization_create[:organization]).serializable_hash
    else 
      render json: { errors: organization_create[:errors] }, status: :unprocessable_entity
    end
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
