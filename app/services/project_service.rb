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

  def create_project(name:)
    project = @organization.projects.build(name: name)

    return { status: true, project: project } if project.save

    { status: false, errors: project.errors.full_messages }
  end

  def update(id:, name:)
    project = def_project(id: id)

    return { status: true, project: project } if project.update(name: name)

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
