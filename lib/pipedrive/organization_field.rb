module Pipedrive
  class OrganizationField < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Delete

    def entity_name
      'organizationFields'
    end
  end
end
