# frozen_string_literal: true

module Pipedrive
  class OrganizationRelationship < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete

    def entity_name
      'organizationRelationships'
    end
  end
end
