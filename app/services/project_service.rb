# frozen_string_literal: true

# project service class
class ProjectService
  def initialize(organization_id:)
    @organization = Organization.find(organization_id)
  end

  def project(id:)
    def_project(id: id)
  end

  def projects
    @organization.projects
  end

  def create_project(params:)
    project = @organization.projects.build(params)

    return { status: true, project: project } if project.save

    { status: false, errors: project.errors.full_messages }
  end

  def update(id:, params:)
    project = def_project(id: id)

    return { status: true, project: project } if project.update(params)

    { status: false, errors: project.errors.full_messages }
  end

  def destroy(id:)
    def_project(id: id).destroy
  end

  private

  def def_project(id:)
    @organization.projects.find(id)
  end
end
