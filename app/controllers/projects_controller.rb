# frozen_string_literal: true

# Exposes API for interacting with Projects.
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_project_service

  def index
    projects = @project_service.projects

    render json: ProjectSerializer.new(projects).serializable_hash
  end

  def create
    create_project = @project_service.create_project(name: project_params[:name])

    if create_project[:status]
      render json: ProjectSerializer.new(create_project[:project]).serializable_hash
    else
      render json: { errors: create_project[:errors] }, status: :unprocessable_entity
    end
  end

  def show
    project = @project_service.project(id: params[:id])

    render json: ProjectSerializer.new(project).serializable_hash
  end

  def update
    updated_project = @project_service.update(id: params[:id], name: project_params[:name])

    if updated_project[:status]
      render json: ProjectSerializer.new(updated_project[:project]).serializable_hash
    else
      render json: { errors: updated_project[:errors] }, status: :unprocessable_entity
    end
  end

  def destroy
    @project_service.destroy(id: params[:id])
    head :ok
  end

  private

  def initialize_project_service
    @project_service = ProjectService.new(
      organization_id: params[:organization_id]
    )
  end

  def project_params
    params.permit(:name)
  end
end
