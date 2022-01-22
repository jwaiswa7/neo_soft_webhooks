# frozen_string_literal: true

# Exposes API for interacting with Organizations.
class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  def create 
    @organization = Organization.new(organization_params)
    if @organization.save
      UserOrganization.new(user: current_user, organization: @organization)
      render json: OrganizationSerializer.new(@organization).serializable_hash 
    else
      render json: @organization.errors
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
