# frozen_string_literal: true

# project service class
class ProjectService
  def initialize(organization_id:)
    @organization = Organization.find(organization_id)
  end

  def project(project_id:)
    def_project(project_id: project_id)
  end

  def projects
    @organization.projects
  end

  def create_project(name:)
    project = @organization.projects.build(name: name)

    return { status: true, project: project } if project.save

    { status: false, errors: project.errors.full_messages }
  end

  def update(project_id:, name:)
    project = def_project(project_id: project_id)

    return { status: true, project: project } if project.update(name: name)

    { status: false, errors: project.errors.full_messages }
  end

  def destroy(project_id:)
    def_project(project_id: project_id).destroy
  end

  private

  def def_project(project_id:)
    @organization.projects.find(project_id)
  end
end
