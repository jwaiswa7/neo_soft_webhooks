# frozen_string_literal: true

# creates an organization
class OrganizationCreator
  def initialize(user_id:, organization_name:)
    @user = User.find(user_id)
    @organization_name = organization_name
    raise 'Organization name required' if @organization_name.blank?
  end

  def call
    organization = Organization.new(name: @organization_name)
    organization.save
    UserOrganization.new(user: @user, organization: organization)
    organization
  end
end
