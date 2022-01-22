# frozen_string_literal: true

# Exposes API for interacting with Tasks.
class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_task_service

  def index
    render json: TaskSerializer.new(@task_service.tasks).serializable_hash
  end

  def create
    create_task = @task_service.create_task(
      params: task_params
    )

    if create_task[:status]
      render json: TaskSerializer.new(create_task[:task]).serializable_hash
    else
      render json: { errors: create_task[:errors] }, status: :unprocessable_entity
    end
  end

  def show
    task = @task_service.task(id: params[:id])

    render json: TaskSerializer.new(task).serializable_hash
  end

  def update
    updated_task = @task_service.update(id: params[:id], params: task_params)

    if updated_task[:status]
      render json: TaskSerializer.new(updated_task[:task]).serializable_hash
    else
      render json: { errors: updated_task[:errors] }, status: :unprocessable_entity
    end
  end

  def destroy
    @task_service.destroy(id: params[:id])
    head :ok
  end

  private

  def initialize_task_service
    @task_service = TaskService.new(
      project_id: params[:project_id]
    )
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.permit(:name, :description)
  end
end
