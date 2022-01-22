# frozen_string_literal: true

# Exposes API for interacting with Tasks.
class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_task_service
  before_action :find_project
  before_action :find_task, only: %i[show update destroy]

  def index
    render json: TaskSerializer.new(@task_service.tasks).serializable_hash
  end

  def create
    create_task = @task_service.create_task(
      name: task_params[:name],
      description: task_params[:description]
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
    if @task.update(task_params)
      render json: TaskSerializer.new(@task).serializable_hash
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
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
