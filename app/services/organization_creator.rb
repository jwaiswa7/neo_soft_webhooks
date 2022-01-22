# frozen_string_literal: true

# creates an organization
class OrganizationCreator
  def initialize(user_id:, organization_name:)
    @user = User.find(user_id)
    @organization_name = organization_name
  end

  def call
    @organization = Organization.new(name: @organization_name)
    if @organization.save
      create_user_organization
      { status: true, organization: @organization }
    else
      { status: false, errors: @organization.errors.full_messages }
    end
  end

  private

  def create_user_organization
    UserOrganization.new(user: @user, organization: @organization)
  end
end
