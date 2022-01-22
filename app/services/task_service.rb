# frozen_string_literal: true

# task service class
class TaskService
  def initialize(project_id:)
    @project = Project.find(project_id)
  end

  def task(id:)
    def_task(id: id)
  end

  def tasks
    @project.tasks
  end

  def create_task(params:)
    task = @project.tasks.build(params)

    return { status: true, task: task } if task.save

    { status: false, errors: task.errors.full_messages }
  end

  def update(id:, params:)
    task = def_task(id: id)

    return { status: true, task: task } if task.update(params)

    { status: false, errors: task.errors.full_messages }
  end

  def destroy(id:)
    def_task(id: id).destroy
  end

  private

  def def_task(id:)
    @project.tasks.find(id)
  end
end
